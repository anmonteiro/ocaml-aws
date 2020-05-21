open Aws
open Aws.BaseTypes
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
module Tag =
  struct
    type t =
      {
      key: String.t [@ocaml.doc "<p>Name of the tag.</p>"];
      value: String.t [@ocaml.doc "<p>Value of the tag.</p>"]}[@@ocaml.doc
                                                                "<p>A container of a key value name pair.</p>"]
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
  end[@@ocaml.doc "<p>A container of a key value name pair.</p>"]
module AnalyticsS3ExportFileFormat =
  struct
    type t =
      | CSV 
    let str_to_t = [("CSV", CSV)]
    let t_to_str = [(CSV, "CSV")]
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
module FilterRule =
  struct
    type t =
      {
      name: FilterRuleName.t option
        [@ocaml.doc
          "<p>The object key name prefix or suffix identifying one or more objects to which the filtering rule applies. The maximum length is 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Configuring Event Notifications</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      value: String.t option
        [@ocaml.doc
          "<p>The value that the filter searches for in object key names.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the Amazon S3 object key name to filter on and whether to filter on the suffix or prefix of the key name.</p>"]
    let make ?name  ?value  () = { name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.name
             (fun f -> ("name", (FilterRuleName.to_json f)))])
    let parse xml =
      Some
        {
          name =
            (Util.option_bind (Xml.member "Name" xml) FilterRuleName.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.name
               (fun f ->
                  Ezxmlm.make_tag "Name" ([], (FilterRuleName.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies the Amazon S3 object key name to filter on and whether to filter on the suffix or prefix of the key name.</p>"]
module OwnerOverride =
  struct
    type t =
      | Destination 
    let str_to_t = [("Destination", Destination)]
    let t_to_str = [(Destination, "Destination")]
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
module ReplicationTimeValue =
  struct
    type t =
      {
      minutes: Integer.t option
        [@ocaml.doc
          "<p> Contains an integer specifying time in minutes. </p> <p> Valid values: 15 minutes. </p>"]}
    [@@ocaml.doc
      "<p> A container specifying the time value for S3 Replication Time Control (S3 RTC) and replication metrics <code>EventThreshold</code>. </p>"]
    let make ?minutes  () = { minutes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.minutes
              (fun f -> ("minutes", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          minutes =
            (Util.option_bind (Xml.member "Minutes" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.minutes
              (fun f -> Ezxmlm.make_tag "Minutes" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p> A container specifying the time value for S3 Replication Time Control (S3 RTC) and replication metrics <code>EventThreshold</code>. </p>"]
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
module TagSet =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "Tag" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
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
module AnalyticsS3BucketDestination =
  struct
    type t =
      {
      format: AnalyticsS3ExportFileFormat.t
        [@ocaml.doc
          "<p>Specifies the file format used when exporting data to Amazon S3.</p>"];
      bucket_account_id: String.t option
        [@ocaml.doc
          "<p>The account ID that owns the destination bucket. If no account ID is provided, the owner will not be validated prior to exporting data.</p>"];
      bucket: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the bucket to which data is exported.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>The prefix to use when exporting data. The prefix is prepended to all results.</p>"]}
    [@@ocaml.doc
      "<p>Contains information about where to publish the analytics results.</p>"]
    let make ~format  ?bucket_account_id  ~bucket  ?prefix  () =
      { format; bucket_account_id; bucket; prefix }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> ("prefix", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.bucket_account_id
             (fun f -> ("bucket_account_id", (String.to_json f)));
           Some ("format", (AnalyticsS3ExportFileFormat.to_json v.format))])
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
  end[@@ocaml.doc
       "<p>Contains information about where to publish the analytics results.</p>"]
module Grantee =
  struct
    type t =
      {
      display_name: String.t option
        [@ocaml.doc "<p>Screen name of the grantee.</p>"];
      email_address: String.t option
        [@ocaml.doc "<p>Email address of the grantee.</p>"];
      i_d: String.t option
        [@ocaml.doc "<p>The canonical user ID of the grantee.</p>"];
      type_: Type.t [@ocaml.doc "<p>Type of grantee</p>"];
      u_r_i: String.t option [@ocaml.doc "<p>URI of the grantee group.</p>"]}
    [@@ocaml.doc
      "<p>Container for the person being granted permissions.</p>"]
    let make ?display_name  ?email_address  ?i_d  ~type_  ?u_r_i  () =
      { display_name; email_address; i_d; type_; u_r_i }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Container for the person being granted permissions.</p>"]
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
module SSEKMS =
  struct
    type t =
      {
      key_id: String.t
        [@ocaml.doc
          "<p>Specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) to use for encrypting inventory reports.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the use of SSE-KMS to encrypt delivered inventory reports.</p>"]
    let make ~key_id  () = { key_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("key_id", (String.to_json v.key_id))])
    let parse xml =
      Some
        {
          key_id =
            (Xml.required "KeyId"
               (Util.option_bind (Xml.member "KeyId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "KeyId" ([], (String.to_xml v.key_id)))])
  end[@@ocaml.doc
       "<p>Specifies the use of SSE-KMS to encrypt delivered inventory reports.</p>"]
module SSES3 =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Specifies the use of SSE-S3 to encrypt delivered inventory reports.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc
       "<p>Specifies the use of SSE-S3 to encrypt delivered inventory reports.</p>"]
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
module FilterRuleList =
  struct
    type t = FilterRule.t list[@@ocaml.doc
                                "<p>A list of containers for the key-value pair that defines the criteria for the filter rule.</p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list FilterRule.to_query v
    let to_headers v = Headers.to_headers_list FilterRule.to_headers v
    let to_json v = `List (List.map FilterRule.to_json v)
    let parse xml = Util.option_all (List.map FilterRule.parse [xml])
    let to_xml v = List.concat (List.map FilterRule.to_xml v)
  end[@@ocaml.doc
       "<p>A list of containers for the key-value pair that defines the criteria for the filter rule.</p>"]
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
module AccessControlTranslation =
  struct
    type t =
      {
      owner: OwnerOverride.t
        [@ocaml.doc
          "<p>Specifies the replica ownership. For default and valid values, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html\">PUT bucket replication</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]}
    [@@ocaml.doc
      "<p>A container for information about access control for replicas.</p>"]
    let make ~owner  () = { owner }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("owner", (OwnerOverride.to_json v.owner))])
    let parse xml =
      Some
        {
          owner =
            (Xml.required "Owner"
               (Util.option_bind (Xml.member "Owner" xml) OwnerOverride.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Owner" ([], (OwnerOverride.to_xml v.owner)))])
  end[@@ocaml.doc
       "<p>A container for information about access control for replicas.</p>"]
module EncryptionConfiguration =
  struct
    type t =
      {
      replica_kms_key_i_d: String.t option
        [@ocaml.doc
          "<p>Specifies the ID (Key ARN or Alias ARN) of the customer managed customer master key (CMK) stored in AWS Key Management Service (KMS) for the destination bucket. Amazon S3 uses this key to encrypt replica objects. Amazon S3 only supports symmetric customer managed CMKs. For more information, see <a href=\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>Specifies encryption-related information for an Amazon S3 bucket that is a destination for replicated objects.</p>"]
    let make ?replica_kms_key_i_d  () = { replica_kms_key_i_d }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replica_kms_key_i_d
              (fun f -> ("replica_kms_key_i_d", (String.to_json f)))])
    let parse xml =
      Some
        {
          replica_kms_key_i_d =
            (Util.option_bind (Xml.member "ReplicaKmsKeyID" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replica_kms_key_i_d
              (fun f ->
                 Ezxmlm.make_tag "ReplicaKmsKeyID" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies encryption-related information for an Amazon S3 bucket that is a destination for replicated objects.</p>"]
module Metrics =
  struct
    type t =
      {
      status: MetricsStatus.t
        [@ocaml.doc
          "<p> Specifies whether the replication metrics are enabled. </p>"];
      event_threshold: ReplicationTimeValue.t
        [@ocaml.doc
          "<p> A container specifying the time threshold for emitting the <code>s3:Replication:OperationMissedThreshold</code> event. </p>"]}
    [@@ocaml.doc
      "<p> A container specifying replication metrics-related settings enabling metrics and Amazon S3 events for S3 Replication Time Control (S3 RTC). Must be specified together with a <code>ReplicationTime</code> block. </p>"]
    let make ~status  ~event_threshold  () = { status; event_threshold }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_threshold",
                (ReplicationTimeValue.to_json v.event_threshold));
           Some ("status", (MetricsStatus.to_json v.status))])
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
  end[@@ocaml.doc
       "<p> A container specifying replication metrics-related settings enabling metrics and Amazon S3 events for S3 Replication Time Control (S3 RTC). Must be specified together with a <code>ReplicationTime</code> block. </p>"]
module ReplicationTime =
  struct
    type t =
      {
      status: ReplicationTimeStatus.t
        [@ocaml.doc
          "<p> Specifies whether the replication time is enabled. </p>"];
      time: ReplicationTimeValue.t
        [@ocaml.doc
          "<p> A container specifying the time by which replication should be complete for all objects and operations on objects. </p>"]}
    [@@ocaml.doc
      "<p> A container specifying S3 Replication Time Control (S3 RTC) related information, including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a <code>Metrics</code> block. </p>"]
    let make ~status  ~time  () = { status; time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("time", (ReplicationTimeValue.to_json v.time));
           Some ("status", (ReplicationTimeStatus.to_json v.status))])
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
  end[@@ocaml.doc
       "<p> A container specifying S3 Replication Time Control (S3 RTC) related information, including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a <code>Metrics</code> block. </p>"]
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
module ReplicationRuleAndOperator =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>An object key name prefix that identifies the subset of objects to which the rule applies.</p>"];
      tags: TagSet.t
        [@ocaml.doc
          "<p>An array of tags containing key and value pairs.</p>"]}
    [@@ocaml.doc
      "<p>A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter. </p> <p>For example:</p> <ul> <li> <p>If you specify both a <code>Prefix</code> and a <code>Tag</code> filter, wrap these filters in an <code>And</code> tag. </p> </li> <li> <p>If you specify a filter based on multiple tags, wrap the <code>Tag</code> elements in an <code>And</code> tag</p> </li> </ul>"]
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
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
  end[@@ocaml.doc
       "<p>A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter. </p> <p>For example:</p> <ul> <li> <p>If you specify both a <code>Prefix</code> and a <code>Tag</code> filter, wrap these filters in an <code>And</code> tag. </p> </li> <li> <p>If you specify a filter based on multiple tags, wrap the <code>Tag</code> elements in an <code>And</code> tag</p> </li> </ul>"]
module SseKmsEncryptedObjects =
  struct
    type t =
      {
      status: SseKmsEncryptedObjectsStatus.t
        [@ocaml.doc
          "<p>Specifies whether Amazon S3 replicates objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service.</p>"]}
    [@@ocaml.doc
      "<p>A container for filter information for the selection of S3 objects encrypted with AWS KMS.</p>"]
    let make ~status  () = { status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("status", (SseKmsEncryptedObjectsStatus.to_json v.status))])
    let parse xml =
      Some
        {
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  SseKmsEncryptedObjectsStatus.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Status"
                 ([], (SseKmsEncryptedObjectsStatus.to_xml v.status)))])
  end[@@ocaml.doc
       "<p>A container for filter information for the selection of S3 objects encrypted with AWS KMS.</p>"]
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
module AnalyticsExportDestination =
  struct
    type t =
      {
      s3_bucket_destination: AnalyticsS3BucketDestination.t
        [@ocaml.doc
          "<p>A destination signifying output to an S3 bucket.</p>"]}
    [@@ocaml.doc "<p>Where to publish the analytics results.</p>"]
    let make ~s3_bucket_destination  () = { s3_bucket_destination }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("s3_bucket_destination",
                (AnalyticsS3BucketDestination.to_json v.s3_bucket_destination))])
    let parse xml =
      Some
        {
          s3_bucket_destination =
            (Xml.required "S3BucketDestination"
               (Util.option_bind (Xml.member "S3BucketDestination" xml)
                  AnalyticsS3BucketDestination.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "S3BucketDestination"
                 ([],
                   (AnalyticsS3BucketDestination.to_xml
                      v.s3_bucket_destination)))])
  end[@@ocaml.doc "<p>Where to publish the analytics results.</p>"]
module StorageClassAnalysisSchemaVersion =
  struct
    type t =
      | V_1 
    let str_to_t = [("V_1", V_1)]
    let t_to_str = [(V_1, "V_1")]
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
module Grant =
  struct
    type t =
      {
      grantee: Grantee.t option
        [@ocaml.doc "<p>The person being granted permissions.</p>"];
      permission: Permission.t option
        [@ocaml.doc "<p>Specifies the permission given to the grantee.</p>"]}
    [@@ocaml.doc "<p>Container for grant information.</p>"]
    let make ?grantee  ?permission  () = { grantee; permission }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.permission
              (fun f -> ("permission", (Permission.to_json f)));
           Util.option_map v.grantee
             (fun f -> ("grantee", (Grantee.to_json f)))])
    let parse xml =
      Some
        {
          grantee =
            (Util.option_bind (Xml.member "Grantee" xml) Grantee.parse);
          permission =
            (Util.option_bind (Xml.member "Permission" xml) Permission.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.grantee
               (fun f -> Ezxmlm.make_tag "Grantee" ([], (Grantee.to_xml f)))])
           @
           [Util.option_map v.permission
              (fun f ->
                 Ezxmlm.make_tag "Permission" ([], (Permission.to_xml f)))])
  end[@@ocaml.doc "<p>Container for grant information.</p>"]
module MetadataEntry =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>Name of the Object.</p>"];
      value: String.t option [@ocaml.doc "<p>Value of the Object.</p>"]}
    [@@ocaml.doc "<p>A metadata key-value pair to store with an object.</p>"]
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
       "<p>A metadata key-value pair to store with an object.</p>"]
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
module InventoryEncryption =
  struct
    type t =
      {
      s_s_e_s3: SSES3.t option
        [@ocaml.doc
          "<p>Specifies the use of SSE-S3 to encrypt delivered inventory reports.</p>"];
      s_s_e_k_m_s: SSEKMS.t option
        [@ocaml.doc
          "<p>Specifies the use of SSE-KMS to encrypt delivered inventory reports.</p>"]}
    [@@ocaml.doc
      "<p>Contains the type of server-side encryption used to encrypt the inventory results.</p>"]
    let make ?s_s_e_s3  ?s_s_e_k_m_s  () = { s_s_e_s3; s_s_e_k_m_s }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.s_s_e_k_m_s
              (fun f -> ("s_s_e_k_m_s", (SSEKMS.to_json f)));
           Util.option_map v.s_s_e_s3
             (fun f -> ("s_s_e_s3", (SSES3.to_json f)))])
    let parse xml =
      Some
        {
          s_s_e_s3 = (Util.option_bind (Xml.member "SSE-S3" xml) SSES3.parse);
          s_s_e_k_m_s =
            (Util.option_bind (Xml.member "SSE-KMS" xml) SSEKMS.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.s_s_e_s3
               (fun f -> Ezxmlm.make_tag "SSE-S3" ([], (SSES3.to_xml f)))])
           @
           [Util.option_map v.s_s_e_k_m_s
              (fun f -> Ezxmlm.make_tag "SSE-KMS" ([], (SSEKMS.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the type of server-side encryption used to encrypt the inventory results.</p>"]
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
module LifecycleRuleAndOperator =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>Prefix identifying one or more objects to which the rule applies.</p>"];
      tags: TagSet.t
        [@ocaml.doc
          "<p>All of these tags must exist in the object's tag set in order for the rule to apply.</p>"]}
    [@@ocaml.doc
      "<p>This is used in a Lifecycle Rule Filter to apply a logical AND to two or more predicates. The Lifecycle Rule will apply to any object matching all of the predicates configured inside the And operator.</p>"]
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
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
  end[@@ocaml.doc
       "<p>This is used in a Lifecycle Rule Filter to apply a logical AND to two or more predicates. The Lifecycle Rule will apply to any object matching all of the predicates configured inside the And operator.</p>"]
module NoncurrentVersionTransition =
  struct
    type t =
      {
      noncurrent_days: Integer.t
        [@ocaml.doc
          "<p>Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations\">How Amazon S3 Calculates How Long an Object Has Been Noncurrent</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      storage_class: TransitionStorageClass.t
        [@ocaml.doc "<p>The class of storage used to store the object.</p>"]}
    [@@ocaml.doc
      "<p>Container for the transition rule that describes when noncurrent objects transition to the <code>STANDARD_IA</code>, <code>ONEZONE_IA</code>, <code>INTELLIGENT_TIERING</code>, <code>GLACIER</code>, or <code>DEEP_ARCHIVE</code> storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the <code>STANDARD_IA</code>, <code>ONEZONE_IA</code>, <code>INTELLIGENT_TIERING</code>, <code>GLACIER</code>, or <code>DEEP_ARCHIVE</code> storage class at a specific period in the object's lifetime.</p>"]
    let make ~noncurrent_days  ~storage_class  () =
      { noncurrent_days; storage_class }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("storage_class",
                (TransitionStorageClass.to_json v.storage_class));
           Some ("noncurrent_days", (Integer.to_json v.noncurrent_days))])
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
  end[@@ocaml.doc
       "<p>Container for the transition rule that describes when noncurrent objects transition to the <code>STANDARD_IA</code>, <code>ONEZONE_IA</code>, <code>INTELLIGENT_TIERING</code>, <code>GLACIER</code>, or <code>DEEP_ARCHIVE</code> storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the <code>STANDARD_IA</code>, <code>ONEZONE_IA</code>, <code>INTELLIGENT_TIERING</code>, <code>GLACIER</code>, or <code>DEEP_ARCHIVE</code> storage class at a specific period in the object's lifetime.</p>"]
module Transition =
  struct
    type t =
      {
      date: DateTime.t option
        [@ocaml.doc
          "<p>Indicates when objects are transitioned to the specified storage class. The date value must be in ISO 8601 format. The time is always midnight UTC.</p>"];
      days: Integer.t option
        [@ocaml.doc
          "<p>Indicates the number of days after creation when objects are transitioned to the specified storage class. The value must be a positive integer.</p>"];
      storage_class: TransitionStorageClass.t option
        [@ocaml.doc
          "<p>The storage class to which you want the object to transition.</p>"]}
    [@@ocaml.doc
      "<p>Specifies when an object transitions to a specified storage class.</p>"]
    let make ?date  ?days  ?storage_class  () = { date; days; storage_class }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.storage_class
              (fun f -> ("storage_class", (TransitionStorageClass.to_json f)));
           Util.option_map v.days (fun f -> ("days", (Integer.to_json f)));
           Util.option_map v.date (fun f -> ("date", (DateTime.to_json f)))])
    let parse xml =
      Some
        {
          date = (Util.option_bind (Xml.member "Date" xml) DateTime.parse);
          days = (Util.option_bind (Xml.member "Days" xml) Integer.parse);
          storage_class =
            (Util.option_bind (Xml.member "StorageClass" xml)
               TransitionStorageClass.parse)
        }
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
  end[@@ocaml.doc
       "<p>Specifies when an object transitions to a specified storage class.</p>"]
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
      | S3_Replication_OperationReplicatedAfterThreshold [@@ocaml.doc
                                                           "<p>The bucket event for which to send notifications.</p>"]
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
  end[@@ocaml.doc "<p>The bucket event for which to send notifications.</p>"]
module S3KeyFilter =
  struct
    type t = {
      filter_rules: FilterRuleList.t }[@@ocaml.doc
                                        "<p>A container for object key name prefix and suffix filtering rules.</p>"]
    let make ?(filter_rules= [])  () = { filter_rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filter_rules", (FilterRuleList.to_json v.filter_rules))])
    let parse xml =
      Some { filter_rules = (Util.of_option [] (FilterRuleList.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "FilterRule"
                      ([], (FilterRuleList.to_xml [x])))) v.filter_rules))
  end[@@ocaml.doc
       "<p>A container for object key name prefix and suffix filtering rules.</p>"]
module DeleteMarkerReplication =
  struct
    type t =
      {
      status: DeleteMarkerReplicationStatus.t option
        [@ocaml.doc
          "<p>Indicates whether to replicate delete markers.</p> <note> <p> In the current implementation, Amazon S3 doesn't replicate the delete markers. The status must be <code>Disabled</code>. </p> </note>"]}
    [@@ocaml.doc
      "<p>Specifies whether Amazon S3 replicates the delete markers. If you specify a <code>Filter</code>, you must specify this element. However, in the latest version of replication configuration (when <code>Filter</code> is specified), Amazon S3 doesn't replicate delete markers. Therefore, the <code>DeleteMarkerReplication</code> element can contain only &lt;Status&gt;Disabled&lt;/Status&gt;. For an example configuration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-config-min-rule-config\">Basic Rule Configuration</a>. </p> <note> <p> If you don't specify the <code>Filter</code> element, Amazon S3 assumes that the replication configuration is the earlier version, V1. In the earlier version, Amazon S3 handled replication of delete markers differently. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-backward-compat-considerations\">Backward Compatibility</a>.</p> </note>"]
    let make ?status  () = { status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (DeleteMarkerReplicationStatus.to_json f)))])
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               DeleteMarkerReplicationStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (DeleteMarkerReplicationStatus.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies whether Amazon S3 replicates the delete markers. If you specify a <code>Filter</code>, you must specify this element. However, in the latest version of replication configuration (when <code>Filter</code> is specified), Amazon S3 doesn't replicate delete markers. Therefore, the <code>DeleteMarkerReplication</code> element can contain only &lt;Status&gt;Disabled&lt;/Status&gt;. For an example configuration, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-config-min-rule-config\">Basic Rule Configuration</a>. </p> <note> <p> If you don't specify the <code>Filter</code> element, Amazon S3 assumes that the replication configuration is the earlier version, V1. In the earlier version, Amazon S3 handled replication of delete markers differently. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-backward-compat-considerations\">Backward Compatibility</a>.</p> </note>"]
module Destination =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p> The Amazon Resource Name (ARN) of the bucket where you want Amazon S3 to store the results.</p>"];
      account: String.t option
        [@ocaml.doc
          "<p>Destination bucket owner account ID. In a cross-account scenario, if you direct Amazon S3 to change replica ownership to the AWS account that owns the destination bucket by specifying the <code>AccessControlTranslation</code> property, this is the account ID of the destination bucket owner. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-change-owner.html\">Replication Additional Configuration: Changing the Replica Owner</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      storage_class: StorageClass.t option
        [@ocaml.doc
          "<p> The storage class to use when replicating objects, such as standard or reduced redundancy. By default, Amazon S3 uses the storage class of the source object to create the object replica. </p> <p>For valid values, see the <code>StorageClass</code> element of the <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html\">PUT Bucket replication</a> action in the <i>Amazon Simple Storage Service API Reference</i>.</p>"];
      access_control_translation: AccessControlTranslation.t option
        [@ocaml.doc
          "<p>Specify this only in a cross-account scenario (where source and destination bucket owners are not the same), and you want to change replica ownership to the AWS account that owns the destination bucket. If this is not specified in the replication configuration, the replicas are owned by same AWS account that owns the source object.</p>"];
      encryption_configuration: EncryptionConfiguration.t option
        [@ocaml.doc
          "<p>A container that provides information about encryption. If <code>SourceSelectionCriteria</code> is specified, you must specify this element.</p>"];
      replication_time: ReplicationTime.t option
        [@ocaml.doc
          "<p> A container specifying S3 Replication Time Control (S3 RTC), including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a <code>Metrics</code> block. </p>"];
      metrics: Metrics.t option
        [@ocaml.doc
          "<p> A container specifying replication metrics-related settings enabling metrics and Amazon S3 events for S3 Replication Time Control (S3 RTC). Must be specified together with a <code>ReplicationTime</code> block. </p>"]}
    [@@ocaml.doc
      "<p>Specifies information about where to publish analysis or configuration results for an Amazon S3 bucket and S3 Replication Time Control (S3 RTC).</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Specifies information about where to publish analysis or configuration results for an Amazon S3 bucket and S3 Replication Time Control (S3 RTC).</p>"]
module ExistingObjectReplication =
  struct
    type t = {
      status: ExistingObjectReplicationStatus.t [@ocaml.doc "<p/>"]}[@@ocaml.doc
                                                                    "<p>Optional configuration to replicate existing source bucket objects. For more information, see <a href=\" https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-what-is-isnot-replicated.html#existing-object-replication\">Replicating Existing Objects</a> in the <i>Amazon S3 Developer Guide</i>. </p>"]
    let make ~status  () = { status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("status", (ExistingObjectReplicationStatus.to_json v.status))])
    let parse xml =
      Some
        {
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  ExistingObjectReplicationStatus.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Status"
                 ([], (ExistingObjectReplicationStatus.to_xml v.status)))])
  end[@@ocaml.doc
       "<p>Optional configuration to replicate existing source bucket objects. For more information, see <a href=\" https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-what-is-isnot-replicated.html#existing-object-replication\">Replicating Existing Objects</a> in the <i>Amazon S3 Developer Guide</i>. </p>"]
module ReplicationRuleFilter =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>An object key name prefix that identifies the subset of objects to which the rule applies.</p>"];
      tag: Tag.t option
        [@ocaml.doc
          "<p>A container for specifying a tag key and value. </p> <p>The rule applies only to objects that have the tag in their tag set.</p>"];
      and_: ReplicationRuleAndOperator.t option
        [@ocaml.doc
          "<p>A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter. For example: </p> <ul> <li> <p>If you specify both a <code>Prefix</code> and a <code>Tag</code> filter, wrap these filters in an <code>And</code> tag.</p> </li> <li> <p>If you specify a filter based on multiple tags, wrap the <code>Tag</code> elements in an <code>And</code> tag.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>A filter that identifies the subset of objects to which the replication rule applies. A <code>Filter</code> must specify exactly one <code>Prefix</code>, <code>Tag</code>, or an <code>And</code> child element.</p>"]
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (ReplicationRuleAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml)
               ReplicationRuleAndOperator.parse)
        }
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
  end[@@ocaml.doc
       "<p>A filter that identifies the subset of objects to which the replication rule applies. A <code>Filter</code> must specify exactly one <code>Prefix</code>, <code>Tag</code>, or an <code>And</code> child element.</p>"]
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
module SourceSelectionCriteria =
  struct
    type t =
      {
      sse_kms_encrypted_objects: SseKmsEncryptedObjects.t option
        [@ocaml.doc
          "<p> A container for filter information for the selection of Amazon S3 objects encrypted with AWS KMS. If you include <code>SourceSelectionCriteria</code> in the replication configuration, this element is required. </p>"]}
    [@@ocaml.doc
      "<p>A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects. Currently, Amazon S3 supports only the filter that you can specify for objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service (SSE-KMS).</p>"]
    let make ?sse_kms_encrypted_objects  () = { sse_kms_encrypted_objects }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.sse_kms_encrypted_objects
              (fun f ->
                 ("sse_kms_encrypted_objects",
                   (SseKmsEncryptedObjects.to_json f)))])
    let parse xml =
      Some
        {
          sse_kms_encrypted_objects =
            (Util.option_bind (Xml.member "SseKmsEncryptedObjects" xml)
               SseKmsEncryptedObjects.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.sse_kms_encrypted_objects
              (fun f ->
                 Ezxmlm.make_tag "SseKmsEncryptedObjects"
                   ([], (SseKmsEncryptedObjects.to_xml f)))])
  end[@@ocaml.doc
       "<p>A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects. Currently, Amazon S3 supports only the filter that you can specify for objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service (SSE-KMS).</p>"]
module ServerSideEncryptionByDefault =
  struct
    type t =
      {
      s_s_e_algorithm: ServerSideEncryption.t
        [@ocaml.doc
          "<p>Server-side encryption algorithm to use for the default encryption.</p>"];
      k_m_s_master_key_i_d: String.t option
        [@ocaml.doc
          "<p>KMS master key ID to use for the default encryption. This parameter is allowed if and only if <code>SSEAlgorithm</code> is set to <code>aws:kms</code>.</p>"]}
    [@@ocaml.doc
      "<p>Describes the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTencryption.html\">PUT Bucket encryption</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
    let make ~s_s_e_algorithm  ?k_m_s_master_key_i_d  () =
      { s_s_e_algorithm; k_m_s_master_key_i_d }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.k_m_s_master_key_i_d
              (fun f -> ("k_m_s_master_key_i_d", (String.to_json f)));
           Some
             ("s_s_e_algorithm",
               (ServerSideEncryption.to_json v.s_s_e_algorithm))])
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
  end[@@ocaml.doc
       "<p>Describes the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTencryption.html\">PUT Bucket encryption</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
module AbortIncompleteMultipartUpload =
  struct
    type t =
      {
      days_after_initiation: Integer.t option
        [@ocaml.doc
          "<p>Specifies the number of days after which Amazon S3 aborts an incomplete multipart upload.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\"> Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
    let make ?days_after_initiation  () = { days_after_initiation }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.days_after_initiation
              (fun f -> ("days_after_initiation", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          days_after_initiation =
            (Util.option_bind (Xml.member "DaysAfterInitiation" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.days_after_initiation
              (fun f ->
                 Ezxmlm.make_tag "DaysAfterInitiation"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\"> Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
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
module LifecycleExpiration =
  struct
    type t =
      {
      date: DateTime.t option
        [@ocaml.doc
          "<p>Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.</p>"];
      days: Integer.t option
        [@ocaml.doc
          "<p>Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.</p>"];
      expired_object_delete_marker: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions. If set to true, the delete marker will be expired; if set to false the policy takes no action. This cannot be specified with Days or Date in a Lifecycle Expiration Policy.</p>"]}
    [@@ocaml.doc
      "<p>Container for the expiration for the lifecycle of the object.</p>"]
    let make ?date  ?days  ?expired_object_delete_marker  () =
      { date; days; expired_object_delete_marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.expired_object_delete_marker
              (fun f -> ("expired_object_delete_marker", (Boolean.to_json f)));
           Util.option_map v.days (fun f -> ("days", (Integer.to_json f)));
           Util.option_map v.date (fun f -> ("date", (DateTime.to_json f)))])
    let parse xml =
      Some
        {
          date = (Util.option_bind (Xml.member "Date" xml) DateTime.parse);
          days = (Util.option_bind (Xml.member "Days" xml) Integer.parse);
          expired_object_delete_marker =
            (Util.option_bind (Xml.member "ExpiredObjectDeleteMarker" xml)
               Boolean.parse)
        }
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
  end[@@ocaml.doc
       "<p>Container for the expiration for the lifecycle of the object.</p>"]
module NoncurrentVersionExpiration =
  struct
    type t =
      {
      noncurrent_days: Integer.t
        [@ocaml.doc
          "<p>Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations\">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>Specifies when noncurrent object versions expire. Upon expiration, Amazon S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that Amazon S3 delete noncurrent object versions at a specific period in the object's lifetime.</p>"]
    let make ~noncurrent_days  () = { noncurrent_days }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("noncurrent_days", (Integer.to_json v.noncurrent_days))])
    let parse xml =
      Some
        {
          noncurrent_days =
            (Xml.required "NoncurrentDays"
               (Util.option_bind (Xml.member "NoncurrentDays" xml)
                  Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "NoncurrentDays"
                 ([], (Integer.to_xml v.noncurrent_days)))])
  end[@@ocaml.doc
       "<p>Specifies when noncurrent object versions expire. Upon expiration, Amazon S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that Amazon S3 delete noncurrent object versions at a specific period in the object's lifetime.</p>"]
module AnalyticsAndOperator =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>The prefix to use when evaluating an AND predicate: The prefix that an object must have to be included in the metrics results.</p>"];
      tags: TagSet.t
        [@ocaml.doc
          "<p>The list of tags to use when evaluating an AND predicate.</p>"]}
    [@@ocaml.doc
      "<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates in any combination, and an object must match all of the predicates for the filter to apply.</p>"]
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
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
  end[@@ocaml.doc
       "<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates in any combination, and an object must match all of the predicates for the filter to apply.</p>"]
module StorageClassAnalysisDataExport =
  struct
    type t =
      {
      output_schema_version: StorageClassAnalysisSchemaVersion.t
        [@ocaml.doc
          "<p>The version of the output schema to use when exporting data. Must be <code>V_1</code>.</p>"];
      destination: AnalyticsExportDestination.t
        [@ocaml.doc "<p>The place to store the data for an analysis.</p>"]}
    [@@ocaml.doc
      "<p>Container for data related to the storage class analysis for an Amazon S3 bucket for export.</p>"]
    let make ~output_schema_version  ~destination  () =
      { output_schema_version; destination }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Container for data related to the storage class analysis for an Amazon S3 bucket for export.</p>"]
module Encryption =
  struct
    type t =
      {
      encryption_type: ServerSideEncryption.t
        [@ocaml.doc
          "<p>The server-side encryption algorithm used when storing job results in Amazon S3 (for example, AES256, aws:kms).</p>"];
      k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If the encryption type is <code>aws:kms</code>, this optional value specifies the ID of the symmetric customer managed AWS KMS CMK to use for encryption of job results. Amazon S3 only supports symmetric CMKs. For more information, see <a href=\"https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html\">Using Symmetric and Asymmetric Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>"];
      k_m_s_context: String.t option
        [@ocaml.doc
          "<p>If the encryption type is <code>aws:kms</code>, this optional value can be used to specify the encryption context for the restore results.</p>"]}
    [@@ocaml.doc "<p>Contains the type of server-side encryption used.</p>"]
    let make ~encryption_type  ?k_m_s_key_id  ?k_m_s_context  () =
      { encryption_type; k_m_s_key_id; k_m_s_context }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc "<p>Contains the type of server-side encryption used.</p>"]
module Grants =
  struct
    type t = Grant.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Grant.to_query v
    let to_headers v = Headers.to_headers_list Grant.to_headers v
    let to_json v = `List (List.map Grant.to_json v)
    let parse xml =
      Util.option_all (List.map Grant.parse (Xml.members "Grant" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Grant.to_xml x))) v
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
module Tagging =
  struct
    type t =
      {
      tag_set: TagSet.t [@ocaml.doc "<p>A collection for a set of tags</p>"]}
    [@@ocaml.doc "<p>Container for <code>TagSet</code> elements.</p>"]
    let make ~tag_set  () = { tag_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("tag_set", (TagSet.to_json v.tag_set))])
    let parse xml =
      Some
        {
          tag_set =
            (Xml.required "TagSet"
               (Util.option_bind (Xml.member "TagSet" xml) TagSet.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagSet" ([], (TagSet.to_xml [x]))))
              v.tag_set))
  end[@@ocaml.doc "<p>Container for <code>TagSet</code> elements.</p>"]
module UserMetadata =
  struct
    type t = MetadataEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetadataEntry.to_query v
    let to_headers v = Headers.to_headers_list MetadataEntry.to_headers v
    let to_json v = `List (List.map MetadataEntry.to_json v)
    let parse xml =
      Util.option_all
        (List.map MetadataEntry.parse (Xml.members "MetadataEntry" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetadataEntry.to_xml x))) v
  end
module CSVInput =
  struct
    type t =
      {
      file_header_info: FileHeaderInfo.t option
        [@ocaml.doc
          "<p>Describes the first line of input. Valid values are:</p> <ul> <li> <p> <code>NONE</code>: First line is not a header.</p> </li> <li> <p> <code>IGNORE</code>: First line is a header, but you can't use the header values to indicate the column in an expression. You can use column position (such as _1, _2, \226\128\166) to indicate the column (<code>SELECT s._1 FROM OBJECT s</code>).</p> </li> <li> <p> <code>Use</code>: First line is a header, and you can use the header value to identify a column in an expression (<code>SELECT \"name\" FROM OBJECT</code>). </p> </li> </ul>"];
      comments: String.t option
        [@ocaml.doc
          "<p>A single character used to indicate that a row should be ignored when the character is present at the start of that row. You can specify any character to indicate a comment line.</p>"];
      quote_escape_character: String.t option
        [@ocaml.doc
          "<p>A single character used for escaping the quotation mark character inside an already escaped value. For example, the value \"\"\" a , b \"\"\" is parsed as \" a , b \".</p>"];
      record_delimiter: String.t option
        [@ocaml.doc
          "<p>A single character used to separate individual records in the input. Instead of the default value, you can specify an arbitrary delimiter.</p>"];
      field_delimiter: String.t option
        [@ocaml.doc
          "<p>A single character used to separate individual fields in a record. You can specify an arbitrary delimiter.</p>"];
      quote_character: String.t option
        [@ocaml.doc
          "<p>A single character used for escaping when the field delimiter is part of the value. For example, if the value is <code>a, b</code>, Amazon S3 wraps this field value in quotation marks, as follows: <code>\" a , b \"</code>.</p> <p>Type: String</p> <p>Default: <code>\"</code> </p> <p>Ancestors: <code>CSV</code> </p>"];
      allow_quoted_record_delimiter: Boolean.t option
        [@ocaml.doc
          "<p>Specifies that CSV field values may contain quoted record delimiters and such records should be allowed. Default value is FALSE. Setting this value to TRUE may lower performance.</p>"]}
    [@@ocaml.doc
      "<p>Describes how an uncompressed comma-separated values (CSV)-formatted input object is formatted.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Describes how an uncompressed comma-separated values (CSV)-formatted input object is formatted.</p>"]
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
module JSONInput =
  struct
    type t =
      {
      type_: JSONType.t option
        [@ocaml.doc
          "<p>The type of JSON. Valid values: Document, Lines.</p>"]}
    [@@ocaml.doc
      "<p>Specifies JSON as object's input serialization format.</p>"]
    let make ?type_  () = { type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (JSONType.to_json f)))])
    let parse xml =
      Some
        { type_ = (Util.option_bind (Xml.member "Type" xml) JSONType.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.type_
              (fun f -> Ezxmlm.make_tag "Type" ([], (JSONType.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies JSON as object's input serialization format.</p>"]
module ParquetInput =
  struct
    type t = unit[@@ocaml.doc "<p>Container for Parquet.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>Container for Parquet.</p>"]
module CSVOutput =
  struct
    type t =
      {
      quote_fields: QuoteFields.t option
        [@ocaml.doc
          "<p>Indicates whether to use quotation marks around output fields. </p> <ul> <li> <p> <code>ALWAYS</code>: Always use quotation marks for output fields.</p> </li> <li> <p> <code>ASNEEDED</code>: Use quotation marks for output fields when needed.</p> </li> </ul>"];
      quote_escape_character: String.t option
        [@ocaml.doc
          "<p>The single character used for escaping the quote character inside an already escaped value.</p>"];
      record_delimiter: String.t option
        [@ocaml.doc
          "<p>A single character used to separate individual records in the output. Instead of the default value, you can specify an arbitrary delimiter.</p>"];
      field_delimiter: String.t option
        [@ocaml.doc
          "<p>The value used to separate individual fields in a record. You can specify an arbitrary delimiter.</p>"];
      quote_character: String.t option
        [@ocaml.doc
          "<p>A single character used for escaping when the field delimiter is part of the value. For example, if the value is <code>a, b</code>, Amazon S3 wraps this field value in quotation marks, as follows: <code>\" a , b \"</code>.</p>"]}
    [@@ocaml.doc
      "<p>Describes how uncompressed comma-separated values (CSV)-formatted results are formatted.</p>"]
    let make ?quote_fields  ?quote_escape_character  ?record_delimiter 
      ?field_delimiter  ?quote_character  () =
      {
        quote_fields;
        quote_escape_character;
        record_delimiter;
        field_delimiter;
        quote_character
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Describes how uncompressed comma-separated values (CSV)-formatted results are formatted.</p>"]
module JSONOutput =
  struct
    type t =
      {
      record_delimiter: String.t option
        [@ocaml.doc
          "<p>The value used to separate individual records in the output.</p>"]}
    [@@ocaml.doc
      "<p>Specifies JSON as request's output serialization format.</p>"]
    let make ?record_delimiter  () = { record_delimiter }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.record_delimiter
              (fun f -> ("record_delimiter", (String.to_json f)))])
    let parse xml =
      Some
        {
          record_delimiter =
            (Util.option_bind (Xml.member "RecordDelimiter" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.record_delimiter
              (fun f ->
                 Ezxmlm.make_tag "RecordDelimiter" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies JSON as request's output serialization format.</p>"]
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
module InventoryS3BucketDestination =
  struct
    type t =
      {
      account_id: String.t option
        [@ocaml.doc
          "<p>The ID of the account that owns the destination bucket.</p>"];
      bucket: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the bucket where inventory results will be published.</p>"];
      format: InventoryFormat.t
        [@ocaml.doc
          "<p>Specifies the output format of the inventory results.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>The prefix that is prepended to all inventory results.</p>"];
      encryption: InventoryEncryption.t option
        [@ocaml.doc
          "<p>Contains the type of server-side encryption used to encrypt the inventory results.</p>"]}
    [@@ocaml.doc
      "<p>Contains the bucket name, file format, bucket owner (optional), and prefix (optional) where inventory results are published.</p>"]
    let make ?account_id  ~bucket  ~format  ?prefix  ?encryption  () =
      { account_id; bucket; format; prefix; encryption }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Contains the bucket name, file format, bucket owner (optional), and prefix (optional) where inventory results are published.</p>"]
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
module Condition =
  struct
    type t =
      {
      http_error_code_returned_equals: String.t option
        [@ocaml.doc
          "<p>The HTTP error code when the redirect is applied. In the event of an error, if the error code equals this value, then the specified redirect is applied. Required when parent element <code>Condition</code> is specified and sibling <code>KeyPrefixEquals</code> is not specified. If both are specified, then both must be true for the redirect to be applied.</p>"];
      key_prefix_equals: String.t option
        [@ocaml.doc
          "<p>The object key name prefix when the redirect is applied. For example, to redirect requests for <code>ExamplePage.html</code>, the key prefix will be <code>ExamplePage.html</code>. To redirect request for all pages with the prefix <code>docs/</code>, the key prefix will be <code>/docs</code>, which identifies all objects in the <code>docs/</code> folder. Required when the parent element <code>Condition</code> is specified and sibling <code>HttpErrorCodeReturnedEquals</code> is not specified. If both conditions are specified, both must be true for the redirect to be applied.</p>"]}
    [@@ocaml.doc
      "<p>A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the <code>/docs</code> folder, redirect to the <code>/documents</code> folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.</p>"]
    let make ?http_error_code_returned_equals  ?key_prefix_equals  () =
      { http_error_code_returned_equals; key_prefix_equals }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.key_prefix_equals
              (fun f -> ("key_prefix_equals", (String.to_json f)));
           Util.option_map v.http_error_code_returned_equals
             (fun f ->
                ("http_error_code_returned_equals", (String.to_json f)))])
    let parse xml =
      Some
        {
          http_error_code_returned_equals =
            (Util.option_bind (Xml.member "HttpErrorCodeReturnedEquals" xml)
               String.parse);
          key_prefix_equals =
            (Util.option_bind (Xml.member "KeyPrefixEquals" xml) String.parse)
        }
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
  end[@@ocaml.doc
       "<p>A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the <code>/docs</code> folder, redirect to the <code>/documents</code> folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.</p>"]
module Redirect =
  struct
    type t =
      {
      host_name: String.t option
        [@ocaml.doc "<p>The host name to use in the redirect request.</p>"];
      http_redirect_code: String.t option
        [@ocaml.doc
          "<p>The HTTP redirect code to use on the response. Not required if one of the siblings is present.</p>"];
      protocol: Protocol.t option
        [@ocaml.doc
          "<p>Protocol to use when redirecting requests. The default is the protocol that is used in the original request.</p>"];
      replace_key_prefix_with: String.t option
        [@ocaml.doc
          "<p>The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix <code>docs/</code> (objects in the <code>docs/</code> folder) to <code>documents/</code>, you can set a condition block with <code>KeyPrefixEquals</code> set to <code>docs/</code> and in the Redirect set <code>ReplaceKeyPrefixWith</code> to <code>/documents</code>. Not required if one of the siblings is present. Can be present only if <code>ReplaceKeyWith</code> is not provided.</p>"];
      replace_key_with: String.t option
        [@ocaml.doc
          "<p>The specific object key to use in the redirect request. For example, redirect request to <code>error.html</code>. Not required if one of the siblings is present. Can be present only if <code>ReplaceKeyPrefixWith</code> is not provided.</p>"]}
    [@@ocaml.doc
      "<p>Specifies how requests are redirected. In the event of an error, you can specify a different error code to return.</p>"]
    let make ?host_name  ?http_redirect_code  ?protocol 
      ?replace_key_prefix_with  ?replace_key_with  () =
      {
        host_name;
        http_redirect_code;
        protocol;
        replace_key_prefix_with;
        replace_key_with
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Specifies how requests are redirected. In the event of an error, you can specify a different error code to return.</p>"]
module AllowedHeaders =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module AllowedMethods =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module AllowedOrigins =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module ExposeHeaders =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module MetricsAndOperator =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>The prefix used when evaluating an AND predicate.</p>"];
      tags: TagSet.t
        [@ocaml.doc
          "<p>The list of tags used when evaluating an AND predicate.</p>"]}
    [@@ocaml.doc
      "<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates, and an object must match all of the predicates in order for the filter to apply.</p>"]
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
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
  end[@@ocaml.doc
       "<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates, and an object must match all of the predicates in order for the filter to apply.</p>"]
module TargetGrant =
  struct
    type t =
      {
      grantee: Grantee.t option
        [@ocaml.doc
          "<p>Container for the person being granted permissions.</p>"];
      permission: BucketLogsPermission.t option
        [@ocaml.doc
          "<p>Logging permissions assigned to the Grantee for the bucket.</p>"]}
    [@@ocaml.doc "<p>Container for granting information.</p>"]
    let make ?grantee  ?permission  () = { grantee; permission }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.permission
              (fun f -> ("permission", (BucketLogsPermission.to_json f)));
           Util.option_map v.grantee
             (fun f -> ("grantee", (Grantee.to_json f)))])
    let parse xml =
      Some
        {
          grantee =
            (Util.option_bind (Xml.member "Grantee" xml) Grantee.parse);
          permission =
            (Util.option_bind (Xml.member "Permission" xml)
               BucketLogsPermission.parse)
        }
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
  end[@@ocaml.doc "<p>Container for granting information.</p>"]
module LifecycleRuleFilter =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>Prefix identifying one or more objects to which the rule applies.</p>"];
      tag: Tag.t option
        [@ocaml.doc
          "<p>This tag must exist in the object's tag set in order for the rule to apply.</p>"];
      and_: LifecycleRuleAndOperator.t option }[@@ocaml.doc
                                                 "<p>The <code>Filter</code> is used to identify objects that a Lifecycle Rule applies to. A <code>Filter</code> must have exactly one of <code>Prefix</code>, <code>Tag</code>, or <code>And</code> specified.</p>"]
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (LifecycleRuleAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml)
               LifecycleRuleAndOperator.parse)
        }
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
  end[@@ocaml.doc
       "<p>The <code>Filter</code> is used to identify objects that a Lifecycle Rule applies to. A <code>Filter</code> must have exactly one of <code>Prefix</code>, <code>Tag</code>, or <code>And</code> specified.</p>"]
module NoncurrentVersionTransitionList =
  struct
    type t = NoncurrentVersionTransition.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list NoncurrentVersionTransition.to_query v
    let to_headers v =
      Headers.to_headers_list NoncurrentVersionTransition.to_headers v
    let to_json v = `List (List.map NoncurrentVersionTransition.to_json v)
    let parse xml =
      Util.option_all (List.map NoncurrentVersionTransition.parse [xml])
    let to_xml v =
      List.concat (List.map NoncurrentVersionTransition.to_xml v)
  end
module TransitionList =
  struct
    type t = Transition.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Transition.to_query v
    let to_headers v = Headers.to_headers_list Transition.to_headers v
    let to_json v = `List (List.map Transition.to_json v)
    let parse xml = Util.option_all (List.map Transition.parse [xml])
    let to_xml v = List.concat (List.map Transition.to_xml v)
  end
module EventList =
  struct
    type t = Event.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Event.to_query v
    let to_headers v = Headers.to_headers_list Event.to_headers v
    let to_json v = `List (List.map Event.to_json v)
    let parse xml = Util.option_all (List.map Event.parse [xml])
    let to_xml v = List.concat (List.map Event.to_xml v)
  end
module NotificationConfigurationFilter =
  struct
    type t = {
      key: S3KeyFilter.t option }[@@ocaml.doc
                                   "<p>Specifies object key name filtering rules. For information about key name filtering, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Configuring Event Notifications</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
    let make ?key  () = { key }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.key (fun f -> ("key", (S3KeyFilter.to_json f)))])
    let parse xml =
      Some
        { key = (Util.option_bind (Xml.member "S3Key" xml) S3KeyFilter.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.key
              (fun f -> Ezxmlm.make_tag "S3Key" ([], (S3KeyFilter.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies object key name filtering rules. For information about key name filtering, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Configuring Event Notifications</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
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
module Owner =
  struct
    type t =
      {
      display_name: String.t option
        [@ocaml.doc "<p>Container for the display name of the owner.</p>"];
      i_d: String.t option
        [@ocaml.doc "<p>Container for the ID of the owner.</p>"]}[@@ocaml.doc
                                                                   "<p>Container for the owner's display name and ID.</p>"]
    let make ?display_name  ?i_d  () = { display_name; i_d }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)));
           Util.option_map v.display_name
             (fun f -> ("display_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          display_name =
            (Util.option_bind (Xml.member "DisplayName" xml) String.parse);
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.display_name
               (fun f ->
                  Ezxmlm.make_tag "DisplayName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.i_d
              (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Container for the owner's display name and ID.</p>"]
module ReplicationRule =
  struct
    type t =
      {
      i_d: String.t option
        [@ocaml.doc
          "<p>A unique identifier for the rule. The maximum value is 255 characters.</p>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The priority associated with the rule. If you specify multiple rules in a replication configuration, Amazon S3 prioritizes the rules to prevent conflicts when filtering. If two or more rules identify the same object based on a specified filter, the rule with higher priority takes precedence. For example:</p> <ul> <li> <p>Same object quality prefix-based filter criteria if prefixes you specified in multiple rules overlap </p> </li> <li> <p>Same object qualify tag-based filter criteria specified in multiple rules</p> </li> </ul> <p>For more information, see <a href=\" https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html\">Replication</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>An object key name prefix that identifies the object or objects to which the rule applies. The maximum prefix length is 1,024 characters. To include all objects in a bucket, specify an empty string. </p>"];
      filter: ReplicationRuleFilter.t option ;
      status: ReplicationRuleStatus.t
        [@ocaml.doc "<p>Specifies whether the rule is enabled.</p>"];
      source_selection_criteria: SourceSelectionCriteria.t option
        [@ocaml.doc
          "<p>A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects. Currently, Amazon S3 supports only the filter that you can specify for objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service (SSE-KMS).</p>"];
      existing_object_replication: ExistingObjectReplication.t option
        [@ocaml.doc "<p/>"];
      destination: Destination.t
        [@ocaml.doc
          "<p>A container for information about the replication destination and its configurations including enabling the S3 Replication Time Control (S3 RTC).</p>"];
      delete_marker_replication: DeleteMarkerReplication.t option }[@@ocaml.doc
                                                                    "<p>Specifies which Amazon S3 objects to replicate and where to store the replicas.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Specifies which Amazon S3 objects to replicate and where to store the replicas.</p>"]
module ServerSideEncryptionRule =
  struct
    type t =
      {
      apply_server_side_encryption_by_default:
        ServerSideEncryptionByDefault.t option
        [@ocaml.doc
          "<p>Specifies the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the default server-side encryption configuration.</p>"]
    let make ?apply_server_side_encryption_by_default  () =
      { apply_server_side_encryption_by_default }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.apply_server_side_encryption_by_default
              (fun f ->
                 ("apply_server_side_encryption_by_default",
                   (ServerSideEncryptionByDefault.to_json f)))])
    let parse xml =
      Some
        {
          apply_server_side_encryption_by_default =
            (Util.option_bind
               (Xml.member "ApplyServerSideEncryptionByDefault" xml)
               ServerSideEncryptionByDefault.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.apply_server_side_encryption_by_default
              (fun f ->
                 Ezxmlm.make_tag "ApplyServerSideEncryptionByDefault"
                   ([], (ServerSideEncryptionByDefault.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies the default server-side encryption configuration.</p>"]
module Rule =
  struct
    type t =
      {
      expiration: LifecycleExpiration.t option
        [@ocaml.doc
          "<p>Specifies the expiration for the lifecycle of the object.</p>"];
      i_d: String.t option
        [@ocaml.doc
          "<p>Unique identifier for the rule. The value can't be longer than 255 characters.</p>"];
      prefix: String.t
        [@ocaml.doc
          "<p>Object key prefix that identifies one or more objects to which this rule applies.</p>"];
      status: ExpirationStatus.t
        [@ocaml.doc
          "<p>If <code>Enabled</code>, the rule is currently being applied. If <code>Disabled</code>, the rule is not currently being applied.</p>"];
      transition: Transition.t option
        [@ocaml.doc
          "<p>Specifies when an object transitions to a specified storage class.</p>"];
      noncurrent_version_transition: NoncurrentVersionTransition.t option ;
      noncurrent_version_expiration: NoncurrentVersionExpiration.t option ;
      abort_incomplete_multipart_upload:
        AbortIncompleteMultipartUpload.t option }[@@ocaml.doc
                                                   "<p>Specifies lifecycle rules for an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlifecycle.html\">PUT Bucket lifecycle</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Specifies lifecycle rules for an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlifecycle.html\">PUT Bucket lifecycle</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
module AnalyticsFilter =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>The prefix to use when evaluating an analytics filter.</p>"];
      tag: Tag.t option
        [@ocaml.doc
          "<p>The tag to use when evaluating an analytics filter.</p>"];
      and_: AnalyticsAndOperator.t option
        [@ocaml.doc
          "<p>A conjunction (logical AND) of predicates, which is used in evaluating an analytics filter. The operator must have at least two predicates.</p>"]}
    [@@ocaml.doc
      "<p>The filter used to describe a set of objects for analyses. A filter must have exactly one prefix, one tag, or one conjunction (AnalyticsAndOperator). If no filter is provided, all objects will be considered in any analysis.</p>"]
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (AnalyticsAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml)
               AnalyticsAndOperator.parse)
        }
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
  end[@@ocaml.doc
       "<p>The filter used to describe a set of objects for analyses. A filter must have exactly one prefix, one tag, or one conjunction (AnalyticsAndOperator). If no filter is provided, all objects will be considered in any analysis.</p>"]
module StorageClassAnalysis =
  struct
    type t =
      {
      data_export: StorageClassAnalysisDataExport.t option
        [@ocaml.doc
          "<p>Specifies how data related to the storage class analysis for an Amazon S3 bucket should be exported.</p>"]}
    [@@ocaml.doc
      "<p>Specifies data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes for an Amazon S3 bucket.</p>"]
    let make ?data_export  () = { data_export }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.data_export
              (fun f ->
                 ("data_export", (StorageClassAnalysisDataExport.to_json f)))])
    let parse xml =
      Some
        {
          data_export =
            (Util.option_bind (Xml.member "DataExport" xml)
               StorageClassAnalysisDataExport.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.data_export
              (fun f ->
                 Ezxmlm.make_tag "DataExport"
                   ([], (StorageClassAnalysisDataExport.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes for an Amazon S3 bucket.</p>"]
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
module S3Location =
  struct
    type t =
      {
      bucket_name: String.t
        [@ocaml.doc
          "<p>The name of the bucket where the restore results will be placed.</p>"];
      prefix: String.t
        [@ocaml.doc
          "<p>The prefix that is prepended to the restore results for this request.</p>"];
      encryption: Encryption.t option ;
      canned_a_c_l: ObjectCannedACL.t option
        [@ocaml.doc "<p>The canned ACL to apply to the restore results.</p>"];
      access_control_list: Grants.t
        [@ocaml.doc
          "<p>A list of grants that control access to the staged results.</p>"];
      tagging: Tagging.t option
        [@ocaml.doc
          "<p>The tag-set that is applied to the restore results.</p>"];
      user_metadata: UserMetadata.t
        [@ocaml.doc
          "<p>A list of metadata to store with the restore results in S3.</p>"];
      storage_class: StorageClass.t option
        [@ocaml.doc
          "<p>The class of storage used to store the restore results.</p>"]}
    [@@ocaml.doc
      "<p>Describes an Amazon S3 location that will receive the results of the restore request.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Describes an Amazon S3 location that will receive the results of the restore request.</p>"]
module ExpressionType =
  struct
    type t =
      | SQL 
    let str_to_t = [("SQL", SQL)]
    let t_to_str = [(SQL, "SQL")]
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
module InputSerialization =
  struct
    type t =
      {
      c_s_v: CSVInput.t option
        [@ocaml.doc
          "<p>Describes the serialization of a CSV-encoded object.</p>"];
      compression_type: CompressionType.t option
        [@ocaml.doc
          "<p>Specifies object's compression format. Valid values: NONE, GZIP, BZIP2. Default Value: NONE.</p>"];
      j_s_o_n: JSONInput.t option
        [@ocaml.doc
          "<p>Specifies JSON as object's input serialization format.</p>"];
      parquet: ParquetInput.t option
        [@ocaml.doc
          "<p>Specifies Parquet as object's input serialization format.</p>"]}
    [@@ocaml.doc "<p>Describes the serialization format of the object.</p>"]
    let make ?c_s_v  ?compression_type  ?j_s_o_n  ?parquet  () =
      { c_s_v; compression_type; j_s_o_n; parquet }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc "<p>Describes the serialization format of the object.</p>"]
module OutputSerialization =
  struct
    type t =
      {
      c_s_v: CSVOutput.t option
        [@ocaml.doc
          "<p>Describes the serialization of CSV-encoded Select results.</p>"];
      j_s_o_n: JSONOutput.t option
        [@ocaml.doc
          "<p>Specifies JSON as request's output serialization format.</p>"]}
    [@@ocaml.doc
      "<p>Describes how results of the Select job are serialized.</p>"]
    let make ?c_s_v  ?j_s_o_n  () = { c_s_v; j_s_o_n }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.j_s_o_n
              (fun f -> ("j_s_o_n", (JSONOutput.to_json f)));
           Util.option_map v.c_s_v
             (fun f -> ("c_s_v", (CSVOutput.to_json f)))])
    let parse xml =
      Some
        {
          c_s_v = (Util.option_bind (Xml.member "CSV" xml) CSVOutput.parse);
          j_s_o_n =
            (Util.option_bind (Xml.member "JSON" xml) JSONOutput.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.c_s_v
               (fun f -> Ezxmlm.make_tag "CSV" ([], (CSVOutput.to_xml f)))])
           @
           [Util.option_map v.j_s_o_n
              (fun f -> Ezxmlm.make_tag "JSON" ([], (JSONOutput.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes how results of the Select job are serialized.</p>"]
module ObjectVersionStorageClass =
  struct
    type t =
      | STANDARD 
    let str_to_t = [("STANDARD", STANDARD)]
    let t_to_str = [(STANDARD, "STANDARD")]
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
module DefaultRetention =
  struct
    type t =
      {
      mode: ObjectLockRetentionMode.t option
        [@ocaml.doc
          "<p>The default Object Lock retention mode you want to apply to new objects placed in the specified bucket.</p>"];
      days: Integer.t option
        [@ocaml.doc
          "<p>The number of days that you want to specify for the default retention period.</p>"];
      years: Integer.t option
        [@ocaml.doc
          "<p>The number of years that you want to specify for the default retention period.</p>"]}
    [@@ocaml.doc
      "<p>The container element for specifying the default Object Lock retention settings for new objects placed in the specified bucket.</p>"]
    let make ?mode  ?days  ?years  () = { mode; days; years }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.years (fun f -> ("years", (Integer.to_json f)));
           Util.option_map v.days (fun f -> ("days", (Integer.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ObjectLockRetentionMode.to_json f)))])
    let parse xml =
      Some
        {
          mode =
            (Util.option_bind (Xml.member "Mode" xml)
               ObjectLockRetentionMode.parse);
          days = (Util.option_bind (Xml.member "Days" xml) Integer.parse);
          years = (Util.option_bind (Xml.member "Years" xml) Integer.parse)
        }
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
  end[@@ocaml.doc
       "<p>The container element for specifying the default Object Lock retention settings for new objects placed in the specified bucket.</p>"]
module ObjectIdentifier =
  struct
    type t =
      {
      key: String.t [@ocaml.doc "<p>Key name of the object to delete.</p>"];
      version_id: String.t option
        [@ocaml.doc
          "<p>VersionId for the specific version of the object to delete.</p>"]}
    [@@ocaml.doc
      "<p>Object Identifier is unique value to identify objects.</p>"]
    let make ~key  ?version_id  () = { key; version_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key))])
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))]) @
           [Util.option_map v.version_id
              (fun f -> Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Object Identifier is unique value to identify objects.</p>"]
module InventoryDestination =
  struct
    type t =
      {
      s3_bucket_destination: InventoryS3BucketDestination.t
        [@ocaml.doc
          "<p>Contains the bucket name, file format, bucket owner (optional), and prefix (optional) where inventory results are published.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the inventory configuration for an Amazon S3 bucket.</p>"]
    let make ~s3_bucket_destination  () = { s3_bucket_destination }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("s3_bucket_destination",
                (InventoryS3BucketDestination.to_json v.s3_bucket_destination))])
    let parse xml =
      Some
        {
          s3_bucket_destination =
            (Xml.required "S3BucketDestination"
               (Util.option_bind (Xml.member "S3BucketDestination" xml)
                  InventoryS3BucketDestination.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "S3BucketDestination"
                 ([],
                   (InventoryS3BucketDestination.to_xml
                      v.s3_bucket_destination)))])
  end[@@ocaml.doc
       "<p>Specifies the inventory configuration for an Amazon S3 bucket.</p>"]
module InventoryFilter =
  struct
    type t =
      {
      prefix: String.t
        [@ocaml.doc
          "<p>The prefix that an object must have to be included in the inventory results.</p>"]}
    [@@ocaml.doc
      "<p>Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria.</p>"]
    let make ~prefix  () = { prefix }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("prefix", (String.to_json v.prefix))])
    let parse xml =
      Some
        {
          prefix =
            (Xml.required "Prefix"
               (Util.option_bind (Xml.member "Prefix" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Prefix" ([], (String.to_xml v.prefix)))])
  end[@@ocaml.doc
       "<p>Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria.</p>"]
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
module InventoryOptionalFields =
  struct
    type t = InventoryOptionalField.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryOptionalField.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryOptionalField.to_headers v
    let to_json v = `List (List.map InventoryOptionalField.to_json v)
    let parse xml =
      Util.option_all
        (List.map InventoryOptionalField.parse (Xml.members "Field" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (InventoryOptionalField.to_xml x)))
        v
  end
module InventorySchedule =
  struct
    type t =
      {
      frequency: InventoryFrequency.t
        [@ocaml.doc
          "<p>Specifies how frequently inventory results are produced.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the schedule for generating inventory results.</p>"]
    let make ~frequency  () = { frequency }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("frequency", (InventoryFrequency.to_json v.frequency))])
    let parse xml =
      Some
        {
          frequency =
            (Xml.required "Frequency"
               (Util.option_bind (Xml.member "Frequency" xml)
                  InventoryFrequency.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Frequency"
                 ([], (InventoryFrequency.to_xml v.frequency)))])
  end[@@ocaml.doc
       "<p>Specifies the schedule for generating inventory results.</p>"]
module RoutingRule =
  struct
    type t =
      {
      condition: Condition.t option
        [@ocaml.doc
          "<p>A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the <code>/docs</code> folder, redirect to the <code>/documents</code> folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.</p>"];
      redirect: Redirect.t
        [@ocaml.doc
          "<p>Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can specify a different error code to return.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the redirect behavior and when a redirect is applied.</p>"]
    let make ?condition  ~redirect  () = { condition; redirect }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("redirect", (Redirect.to_json v.redirect));
           Util.option_map v.condition
             (fun f -> ("condition", (Condition.to_json f)))])
    let parse xml =
      Some
        {
          condition =
            (Util.option_bind (Xml.member "Condition" xml) Condition.parse);
          redirect =
            (Xml.required "Redirect"
               (Util.option_bind (Xml.member "Redirect" xml) Redirect.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.condition
               (fun f ->
                  Ezxmlm.make_tag "Condition" ([], (Condition.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "Redirect" ([], (Redirect.to_xml v.redirect)))])
  end[@@ocaml.doc
       "<p>Specifies the redirect behavior and when a redirect is applied.</p>"]
module CORSRule =
  struct
    type t =
      {
      allowed_headers: AllowedHeaders.t
        [@ocaml.doc
          "<p>Headers that are specified in the <code>Access-Control-Request-Headers</code> header. These headers are allowed in a preflight OPTIONS request. In response to any preflight OPTIONS request, Amazon S3 returns any requested headers that are allowed.</p>"];
      allowed_methods: AllowedMethods.t
        [@ocaml.doc
          "<p>An HTTP method that you allow the origin to execute. Valid values are <code>GET</code>, <code>PUT</code>, <code>HEAD</code>, <code>POST</code>, and <code>DELETE</code>.</p>"];
      allowed_origins: AllowedOrigins.t
        [@ocaml.doc
          "<p>One or more origins you want customers to be able to access the bucket from.</p>"];
      expose_headers: ExposeHeaders.t
        [@ocaml.doc
          "<p>One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript <code>XMLHttpRequest</code> object).</p>"];
      max_age_seconds: Integer.t option
        [@ocaml.doc
          "<p>The time in seconds that your browser is to cache the preflight response for the specified resource.</p>"]}
    [@@ocaml.doc
      "<p>Specifies a cross-origin access rule for an Amazon S3 bucket.</p>"]
    let make ?(allowed_headers= [])  ~allowed_methods  ~allowed_origins 
      ?(expose_headers= [])  ?max_age_seconds  () =
      {
        allowed_headers;
        allowed_methods;
        allowed_origins;
        expose_headers;
        max_age_seconds
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Specifies a cross-origin access rule for an Amazon S3 bucket.</p>"]
module MetricsFilter =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc
          "<p>The prefix used when evaluating a metrics filter.</p>"];
      tag: Tag.t option
        [@ocaml.doc "<p>The tag used when evaluating a metrics filter.</p>"];
      and_: MetricsAndOperator.t option
        [@ocaml.doc
          "<p>A conjunction (logical AND) of predicates, which is used in evaluating a metrics filter. The operator must have at least two predicates, and an object must match all of the predicates in order for the filter to apply.</p>"]}
    [@@ocaml.doc
      "<p>Specifies a metrics configuration filter. The metrics configuration only includes objects that meet the filter's criteria. A filter must be a prefix, a tag, or a conjunction (MetricsAndOperator).</p>"]
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (MetricsAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml) MetricsAndOperator.parse)
        }
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
  end[@@ocaml.doc
       "<p>Specifies a metrics configuration filter. The metrics configuration only includes objects that meet the filter's criteria. A filter must be a prefix, a tag, or a conjunction (MetricsAndOperator).</p>"]
module TargetGrants =
  struct
    type t = TargetGrant.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TargetGrant.to_query v
    let to_headers v = Headers.to_headers_list TargetGrant.to_headers v
    let to_json v = `List (List.map TargetGrant.to_json v)
    let parse xml =
      Util.option_all (List.map TargetGrant.parse (Xml.members "Grant" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TargetGrant.to_xml x))) v
  end
module CompletedPart =
  struct
    type t =
      {
      e_tag: String.t
        [@ocaml.doc "<p>Entity tag returned when the part was uploaded.</p>"];
      part_number: Integer.t
        [@ocaml.doc
          "<p>Part number that identifies the part. This is a positive integer between 1 and 10,000.</p>"]}
    [@@ocaml.doc "<p>Details of the parts that were uploaded.</p>"]
    let make ~e_tag  ~part_number  () = { e_tag; part_number }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("part_number", (Integer.to_json v.part_number));
           Some ("e_tag", (String.to_json v.e_tag))])
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
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "ETag" ([], (String.to_xml v.e_tag)))])
           @
           [Some
              (Ezxmlm.make_tag "PartNumber"
                 ([], (Integer.to_xml v.part_number)))])
  end[@@ocaml.doc "<p>Details of the parts that were uploaded.</p>"]
module Progress =
  struct
    type t =
      {
      bytes_scanned: Long.t option
        [@ocaml.doc "<p>The current number of object bytes scanned.</p>"];
      bytes_processed: Long.t option
        [@ocaml.doc
          "<p>The current number of uncompressed object bytes processed.</p>"];
      bytes_returned: Long.t option
        [@ocaml.doc
          "<p>The current number of bytes of records payload data returned.</p>"]}
    [@@ocaml.doc
      "<p>This data type contains information about progress of an operation.</p>"]
    let make ?bytes_scanned  ?bytes_processed  ?bytes_returned  () =
      { bytes_scanned; bytes_processed; bytes_returned }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.bytes_returned
              (fun f -> ("bytes_returned", (Long.to_json f)));
           Util.option_map v.bytes_processed
             (fun f -> ("bytes_processed", (Long.to_json f)));
           Util.option_map v.bytes_scanned
             (fun f -> ("bytes_scanned", (Long.to_json f)))])
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
  end[@@ocaml.doc
       "<p>This data type contains information about progress of an operation.</p>"]
module Stats =
  struct
    type t =
      {
      bytes_scanned: Long.t option
        [@ocaml.doc "<p>The total number of object bytes scanned.</p>"];
      bytes_processed: Long.t option
        [@ocaml.doc
          "<p>The total number of uncompressed object bytes processed.</p>"];
      bytes_returned: Long.t option
        [@ocaml.doc
          "<p>The total number of bytes of records payload data returned.</p>"]}
    [@@ocaml.doc "<p>Container for the stats details.</p>"]
    let make ?bytes_scanned  ?bytes_processed  ?bytes_returned  () =
      { bytes_scanned; bytes_processed; bytes_returned }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.bytes_returned
              (fun f -> ("bytes_returned", (Long.to_json f)));
           Util.option_map v.bytes_processed
             (fun f -> ("bytes_processed", (Long.to_json f)));
           Util.option_map v.bytes_scanned
             (fun f -> ("bytes_scanned", (Long.to_json f)))])
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
  end[@@ocaml.doc "<p>Container for the stats details.</p>"]
module LifecycleRule =
  struct
    type t =
      {
      expiration: LifecycleExpiration.t option
        [@ocaml.doc
          "<p>Specifies the expiration for the lifecycle of the object in the form of date, days and, whether the object has a delete marker.</p>"];
      i_d: String.t option
        [@ocaml.doc
          "<p>Unique identifier for the rule. The value cannot be longer than 255 characters.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>Prefix identifying one or more objects to which the rule applies. This is No longer used; use <code>Filter</code> instead.</p>"];
      filter: LifecycleRuleFilter.t option ;
      status: ExpirationStatus.t
        [@ocaml.doc
          "<p>If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.</p>"];
      transitions: TransitionList.t
        [@ocaml.doc
          "<p>Specifies when an Amazon S3 object transitions to a specified storage class.</p>"];
      noncurrent_version_transitions: NoncurrentVersionTransitionList.t
        [@ocaml.doc
          "<p> Specifies the transition rule for the lifecycle rule that describes when noncurrent objects transition to a specific storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to a specific storage class at a set period in the object's lifetime. </p>"];
      noncurrent_version_expiration: NoncurrentVersionExpiration.t option ;
      abort_incomplete_multipart_upload:
        AbortIncompleteMultipartUpload.t option }[@@ocaml.doc
                                                   "<p>A lifecycle rule for individual objects in an Amazon S3 bucket.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>A lifecycle rule for individual objects in an Amazon S3 bucket.</p>"]
module Initiator =
  struct
    type t =
      {
      i_d: String.t option
        [@ocaml.doc
          "<p>If the principal is an AWS account, it provides the Canonical User ID. If the principal is an IAM User, it provides a user ARN value.</p>"];
      display_name: String.t option
        [@ocaml.doc "<p>Name of the Principal.</p>"]}[@@ocaml.doc
                                                       "<p>Container element that identifies who initiated the multipart upload. </p>"]
    let make ?i_d  ?display_name  () = { i_d; display_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.display_name
              (fun f -> ("display_name", (String.to_json f)));
           Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)))])
    let parse xml =
      Some
        {
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse);
          display_name =
            (Util.option_bind (Xml.member "DisplayName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.i_d
               (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
           @
           [Util.option_map v.display_name
              (fun f -> Ezxmlm.make_tag "DisplayName" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Container element that identifies who initiated the multipart upload. </p>"]
module LambdaFunctionConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      lambda_function_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the AWS Lambda function that Amazon S3 invokes when the specified event type occurs.</p>"];
      events: EventList.t
        [@ocaml.doc
          "<p>The Amazon S3 bucket event for which to invoke the AWS Lambda function. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Supported Event Types</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      filter: NotificationConfigurationFilter.t option }[@@ocaml.doc
                                                          "<p>A container for specifying the configuration for AWS Lambda notifications.</p>"]
    let make ?id  ~lambda_function_arn  ~events  ?filter  () =
      { id; lambda_function_arn; events; filter }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>A container for specifying the configuration for AWS Lambda notifications.</p>"]
module QueueConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      queue_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3 publishes a message when it detects events of the specified type.</p>"];
      events: EventList.t
        [@ocaml.doc
          "<p>A collection of bucket events for which to send notifications</p>"];
      filter: NotificationConfigurationFilter.t option }[@@ocaml.doc
                                                          "<p>Specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events.</p>"]
    let make ?id  ~queue_arn  ~events  ?filter  () =
      { id; queue_arn; events; filter }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.filter
              (fun f ->
                 ("filter", (NotificationConfigurationFilter.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Some ("queue_arn", (String.to_json v.queue_arn));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
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
  end[@@ocaml.doc
       "<p>Specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events.</p>"]
module TopicConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      topic_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon SNS topic to which Amazon S3 publishes a message when it detects events of the specified type.</p>"];
      events: EventList.t
        [@ocaml.doc
          "<p>The Amazon S3 bucket event about which to send notifications. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Supported Event Types</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      filter: NotificationConfigurationFilter.t option }[@@ocaml.doc
                                                          "<p>A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events.</p>"]
    let make ?id  ~topic_arn  ~events  ?filter  () =
      { id; topic_arn; events; filter }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.filter
              (fun f ->
                 ("filter", (NotificationConfigurationFilter.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Some ("topic_arn", (String.to_json v.topic_arn));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
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
  end[@@ocaml.doc
       "<p>A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events.</p>"]
module CommonPrefix =
  struct
    type t =
      {
      prefix: String.t option
        [@ocaml.doc "<p>Container for the specified common prefix.</p>"]}
    [@@ocaml.doc
      "<p>Container for all (if there are any) keys between Prefix and the next occurrence of the string specified by a delimiter. CommonPrefixes lists keys that act like subdirectories in the directory specified by Prefix. For example, if the prefix is notes/ and the delimiter is a slash (/) as in notes/summer/july, the common prefix is notes/summer/. </p>"]
    let make ?prefix  () = { prefix }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> ("prefix", (String.to_json f)))])
    let parse xml =
      Some
        { prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.prefix
              (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Container for all (if there are any) keys between Prefix and the next occurrence of the string specified by a delimiter. CommonPrefixes lists keys that act like subdirectories in the directory specified by Prefix. For example, if the prefix is notes/ and the delimiter is a slash (/) as in notes/summer/july, the common prefix is notes/summer/. </p>"]
module Object =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p>The name that you assign to an object. You use the object key to retrieve the object.</p>"];
      last_modified: DateTime.t
        [@ocaml.doc "<p>The date the Object was Last Modified</p>"];
      e_tag: String.t
        [@ocaml.doc
          "<p>The entity tag is an MD5 hash of the object. ETag reflects only changes to the contents of an object, not its metadata.</p>"];
      size: Integer.t [@ocaml.doc "<p>Size in bytes of the object</p>"];
      storage_class: ObjectStorageClass.t
        [@ocaml.doc "<p>The class of storage used to store the object.</p>"];
      owner: Owner.t option [@ocaml.doc "<p>The owner of the object</p>"]}
    [@@ocaml.doc
      "<p>An object consists of data and its descriptive metadata.</p>"]
    let make ~key  ~last_modified  ~e_tag  ~size  ~storage_class  ?owner  ()
      = { key; last_modified; e_tag; size; storage_class; owner }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>An object consists of data and its descriptive metadata.</p>"]
module ReplicationRules =
  struct
    type t = ReplicationRule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ReplicationRule.to_query v
    let to_headers v = Headers.to_headers_list ReplicationRule.to_headers v
    let to_json v = `List (List.map ReplicationRule.to_json v)
    let parse xml = Util.option_all (List.map ReplicationRule.parse [xml])
    let to_xml v = List.concat (List.map ReplicationRule.to_xml v)
  end
module ServerSideEncryptionRules =
  struct
    type t = ServerSideEncryptionRule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ServerSideEncryptionRule.to_query v
    let to_headers v =
      Headers.to_headers_list ServerSideEncryptionRule.to_headers v
    let to_json v = `List (List.map ServerSideEncryptionRule.to_json v)
    let parse xml =
      Util.option_all (List.map ServerSideEncryptionRule.parse [xml])
    let to_xml v = List.concat (List.map ServerSideEncryptionRule.to_xml v)
  end
module Rules =
  struct
    type t = Rule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Rule.to_query v
    let to_headers v = Headers.to_headers_list Rule.to_headers v
    let to_json v = `List (List.map Rule.to_json v)
    let parse xml = Util.option_all (List.map Rule.parse [xml])
    let to_xml v = List.concat (List.map Rule.to_xml v)
  end
module AnalyticsConfiguration =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID that identifies the analytics configuration.</p>"];
      filter: AnalyticsFilter.t option
        [@ocaml.doc
          "<p>The filter used to describe a set of objects for analyses. A filter must have exactly one prefix, one tag, or one conjunction (AnalyticsAndOperator). If no filter is provided, all objects will be considered in any analysis.</p>"];
      storage_class_analysis: StorageClassAnalysis.t
        [@ocaml.doc
          "<p> Contains data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes. </p>"]}
    [@@ocaml.doc
      "<p> Specifies the configuration and any analyses for the analytics filter of an Amazon S3 bucket.</p>"]
    let make ~id  ?filter  ~storage_class_analysis  () =
      { id; filter; storage_class_analysis }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("storage_class_analysis",
                (StorageClassAnalysis.to_json v.storage_class_analysis));
           Util.option_map v.filter
             (fun f -> ("filter", (AnalyticsFilter.to_json f)));
           Some ("id", (String.to_json v.id))])
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
  end[@@ocaml.doc
       "<p> Specifies the configuration and any analyses for the analytics filter of an Amazon S3 bucket.</p>"]
module GlacierJobParameters =
  struct
    type t =
      {
      tier: Tier.t
        [@ocaml.doc
          "<p>Glacier retrieval tier at which the restore will be processed.</p>"]}
    [@@ocaml.doc "<p>Container for Glacier job parameters.</p>"]
    let make ~tier  () = { tier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("tier", (Tier.to_json v.tier))])
    let parse xml =
      Some
        {
          tier =
            (Xml.required "Tier"
               (Util.option_bind (Xml.member "Tier" xml) Tier.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Tier" ([], (Tier.to_xml v.tier)))])
  end[@@ocaml.doc "<p>Container for Glacier job parameters.</p>"]
module OutputLocation =
  struct
    type t =
      {
      s3: S3Location.t option
        [@ocaml.doc
          "<p>Describes an S3 location that will receive the results of the restore request.</p>"]}
    [@@ocaml.doc
      "<p>Describes the location where the restore job's output is stored.</p>"]
    let make ?s3  () = { s3 }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.s3 (fun f -> ("s3", (S3Location.to_json f)))])
    let parse xml =
      Some { s3 = (Util.option_bind (Xml.member "S3" xml) S3Location.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.s3
              (fun f -> Ezxmlm.make_tag "S3" ([], (S3Location.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes the location where the restore job's output is stored.</p>"]
module RestoreRequestType =
  struct
    type t =
      | SELECT 
    let str_to_t = [("SELECT", SELECT)]
    let t_to_str = [(SELECT, "SELECT")]
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
module SelectParameters =
  struct
    type t =
      {
      input_serialization: InputSerialization.t
        [@ocaml.doc
          "<p>Describes the serialization format of the object.</p>"];
      expression_type: ExpressionType.t
        [@ocaml.doc
          "<p>The type of the provided expression (for example, SQL).</p>"];
      expression: String.t
        [@ocaml.doc
          "<p>The expression that is used to query the object.</p>"];
      output_serialization: OutputSerialization.t
        [@ocaml.doc
          "<p>Describes how the results of the Select job are serialized.</p>"]}
    [@@ocaml.doc "<p>Describes the parameters for Select job types.</p>"]
    let make ~input_serialization  ~expression_type  ~expression 
      ~output_serialization  () =
      {
        input_serialization;
        expression_type;
        expression;
        output_serialization
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc "<p>Describes the parameters for Select job types.</p>"]
module DeleteMarkerEntry =
  struct
    type t =
      {
      owner: Owner.t option
        [@ocaml.doc "<p>The account that created the delete marker.&gt;</p>"];
      key: String.t option [@ocaml.doc "<p>The object key.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>Version ID of an object.</p>"];
      is_latest: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the object is (true) or is not (false) the latest version of an object.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc "<p>Date and time the object was last modified.</p>"]}
    [@@ocaml.doc "<p>Information about the delete marker.</p>"]
    let make ?owner  ?key  ?version_id  ?is_latest  ?last_modified  () =
      { owner; key; version_id; is_latest; last_modified }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc "<p>Information about the delete marker.</p>"]
module ObjectVersion =
  struct
    type t =
      {
      e_tag: String.t option
        [@ocaml.doc
          "<p>The entity tag is an MD5 hash of that version of the object.</p>"];
      size: Integer.t option
        [@ocaml.doc "<p>Size in bytes of the object.</p>"];
      storage_class: ObjectVersionStorageClass.t option
        [@ocaml.doc "<p>The class of storage used to store the object.</p>"];
      key: String.t option [@ocaml.doc "<p>The object key.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>Version ID of an object.</p>"];
      is_latest: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the object is (true) or is not (false) the latest version of an object.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc "<p>Date and time the object was last modified.</p>"];
      owner: Owner.t option
        [@ocaml.doc "<p>Specifies the owner of the object.</p>"]}[@@ocaml.doc
                                                                   "<p>The version of an object.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc "<p>The version of an object.</p>"]
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
module ObjectLockEnabled =
  struct
    type t =
      | Enabled 
    let str_to_t = [("Enabled", Enabled)]
    let t_to_str = [(Enabled, "Enabled")]
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
module ObjectLockRule =
  struct
    type t =
      {
      default_retention: DefaultRetention.t option
        [@ocaml.doc
          "<p>The default retention period that you want to apply to new objects placed in the specified bucket.</p>"]}
    [@@ocaml.doc "<p>The container element for an Object Lock rule.</p>"]
    let make ?default_retention  () = { default_retention }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_retention
              (fun f -> ("default_retention", (DefaultRetention.to_json f)))])
    let parse xml =
      Some
        {
          default_retention =
            (Util.option_bind (Xml.member "DefaultRetention" xml)
               DefaultRetention.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.default_retention
              (fun f ->
                 Ezxmlm.make_tag "DefaultRetention"
                   ([], (DefaultRetention.to_xml f)))])
  end[@@ocaml.doc "<p>The container element for an Object Lock rule.</p>"]
module ObjectIdentifierList =
  struct
    type t = ObjectIdentifier.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ObjectIdentifier.to_query v
    let to_headers v = Headers.to_headers_list ObjectIdentifier.to_headers v
    let to_json v = `List (List.map ObjectIdentifier.to_json v)
    let parse xml = Util.option_all (List.map ObjectIdentifier.parse [xml])
    let to_xml v = List.concat (List.map ObjectIdentifier.to_xml v)
  end
module InventoryConfiguration =
  struct
    type t =
      {
      destination: InventoryDestination.t
        [@ocaml.doc
          "<p>Contains information about where to publish the inventory results.</p>"];
      is_enabled: Boolean.t
        [@ocaml.doc
          "<p>Specifies whether the inventory is enabled or disabled. If set to <code>True</code>, an inventory list is generated. If set to <code>False</code>, no inventory list is generated.</p>"];
      filter: InventoryFilter.t option
        [@ocaml.doc
          "<p>Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria.</p>"];
      id: String.t
        [@ocaml.doc
          "<p>The ID used to identify the inventory configuration.</p>"];
      included_object_versions: InventoryIncludedObjectVersions.t
        [@ocaml.doc
          "<p>Object versions to include in the inventory list. If set to <code>All</code>, the list includes all the object versions, which adds the version-related fields <code>VersionId</code>, <code>IsLatest</code>, and <code>DeleteMarker</code> to the list. If set to <code>Current</code>, the list does not contain these version-related fields.</p>"];
      optional_fields: InventoryOptionalFields.t
        [@ocaml.doc
          "<p>Contains the optional fields that are included in the inventory results.</p>"];
      schedule: InventorySchedule.t
        [@ocaml.doc
          "<p>Specifies the schedule for generating inventory results.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the inventory configuration for an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETInventoryConfig.html\">GET Bucket inventory</a> in the <i>Amazon Simple Storage Service API Reference</i>. </p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Specifies the inventory configuration for an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETInventoryConfig.html\">GET Bucket inventory</a> in the <i>Amazon Simple Storage Service API Reference</i>. </p>"]
module ErrorDocument =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p>The object key name to use when a 4XX class error occurs.</p>"]}
    [@@ocaml.doc "<p>The error information.</p>"]
    let make ~key  () = { key }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("key", (String.to_json v.key))])
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
  end[@@ocaml.doc "<p>The error information.</p>"]
module IndexDocument =
  struct
    type t =
      {
      suffix: String.t
        [@ocaml.doc
          "<p>A suffix that is appended to a request that is for a directory on the website endpoint (for example,if the suffix is index.html and you make a request to samplebucket/images/ the data that is returned will be for the object with the key name images/index.html) The suffix must not be empty and must not include a slash character.</p>"]}
    [@@ocaml.doc "<p>Container for the <code>Suffix</code> element.</p>"]
    let make ~suffix  () = { suffix }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("suffix", (String.to_json v.suffix))])
    let parse xml =
      Some
        {
          suffix =
            (Xml.required "Suffix"
               (Util.option_bind (Xml.member "Suffix" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Suffix" ([], (String.to_xml v.suffix)))])
  end[@@ocaml.doc "<p>Container for the <code>Suffix</code> element.</p>"]
module RedirectAllRequestsTo =
  struct
    type t =
      {
      host_name: String.t
        [@ocaml.doc "<p>Name of the host where requests are redirected.</p>"];
      protocol: Protocol.t option
        [@ocaml.doc
          "<p>Protocol to use when redirecting requests. The default is the protocol that is used in the original request.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the redirect behavior of all requests to a website endpoint of an Amazon S3 bucket.</p>"]
    let make ~host_name  ?protocol  () = { host_name; protocol }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.protocol
              (fun f -> ("protocol", (Protocol.to_json f)));
           Some ("host_name", (String.to_json v.host_name))])
    let parse xml =
      Some
        {
          host_name =
            (Xml.required "HostName"
               (Util.option_bind (Xml.member "HostName" xml) String.parse));
          protocol =
            (Util.option_bind (Xml.member "Protocol" xml) Protocol.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "HostName" ([], (String.to_xml v.host_name)))])
           @
           [Util.option_map v.protocol
              (fun f -> Ezxmlm.make_tag "Protocol" ([], (Protocol.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies the redirect behavior of all requests to a website endpoint of an Amazon S3 bucket.</p>"]
module RoutingRules =
  struct
    type t = RoutingRule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list RoutingRule.to_query v
    let to_headers v = Headers.to_headers_list RoutingRule.to_headers v
    let to_json v = `List (List.map RoutingRule.to_json v)
    let parse xml =
      Util.option_all
        (List.map RoutingRule.parse (Xml.members "RoutingRule" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (RoutingRule.to_xml x))) v
  end
module CORSRules =
  struct
    type t = CORSRule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CORSRule.to_query v
    let to_headers v = Headers.to_headers_list CORSRule.to_headers v
    let to_json v = `List (List.map CORSRule.to_json v)
    let parse xml = Util.option_all (List.map CORSRule.parse [xml])
    let to_xml v = List.concat (List.map CORSRule.to_xml v)
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
module MetricsConfiguration =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID used to identify the metrics configuration.</p>"];
      filter: MetricsFilter.t option
        [@ocaml.doc
          "<p>Specifies a metrics configuration filter. The metrics configuration will only include objects that meet the filter's criteria. A filter must be a prefix, a tag, or a conjunction (MetricsAndOperator).</p>"]}
    [@@ocaml.doc
      "<p>Specifies a metrics configuration for the CloudWatch request metrics (specified by the metrics configuration ID) from an Amazon S3 bucket. If you're updating an existing metrics configuration, note that this is a full replacement of the existing metrics configuration. If you don't include the elements you want to keep, they are erased. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTMetricConfiguration.html\"> PUT Bucket metrics</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
    let make ~id  ?filter  () = { id; filter }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.filter
              (fun f -> ("filter", (MetricsFilter.to_json f)));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          filter =
            (Util.option_bind (Xml.member "Filter" xml) MetricsFilter.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
           [Util.option_map v.filter
              (fun f ->
                 Ezxmlm.make_tag "Filter" ([], (MetricsFilter.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies a metrics configuration for the CloudWatch request metrics (specified by the metrics configuration ID) from an Amazon S3 bucket. If you're updating an existing metrics configuration, note that this is a full replacement of the existing metrics configuration. If you don't include the elements you want to keep, they are erased. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTMetricConfiguration.html\"> PUT Bucket metrics</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
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
module LoggingEnabled =
  struct
    type t =
      {
      target_bucket: String.t
        [@ocaml.doc
          "<p>Specifies the bucket where you want Amazon S3 to store server access logs. You can have your logs delivered to any bucket that you own, including the same bucket that is being logged. You can also configure multiple buckets to deliver their logs to the same target bucket. In this case, you should choose a different <code>TargetPrefix</code> for each source bucket so that the delivered log files can be distinguished by key.</p>"];
      target_grants: TargetGrants.t
        [@ocaml.doc "<p>Container for granting information.</p>"];
      target_prefix: String.t
        [@ocaml.doc
          "<p>A prefix for all log object keys. If you store log files from multiple Amazon S3 buckets in a single bucket, you can use a prefix to distinguish which log files came from which bucket.</p>"]}
    [@@ocaml.doc
      "<p>Describes where logs are stored and the prefix that Amazon S3 assigns to all log object keys for a bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlogging.html\">PUT Bucket logging</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
    let make ~target_bucket  ?(target_grants= [])  ~target_prefix  () =
      { target_bucket; target_grants; target_prefix }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("target_prefix", (String.to_json v.target_prefix));
           Some ("target_grants", (TargetGrants.to_json v.target_grants));
           Some ("target_bucket", (String.to_json v.target_bucket))])
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
  end[@@ocaml.doc
       "<p>Describes where logs are stored and the prefix that Amazon S3 assigns to all log object keys for a bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlogging.html\">PUT Bucket logging</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
module CompletedPartList =
  struct
    type t = CompletedPart.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CompletedPart.to_query v
    let to_headers v = Headers.to_headers_list CompletedPart.to_headers v
    let to_json v = `List (List.map CompletedPart.to_json v)
    let parse xml = Util.option_all (List.map CompletedPart.parse [xml])
    let to_xml v = List.concat (List.map CompletedPart.to_xml v)
  end
module Bucket =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The name of the bucket.</p>"];
      creation_date: DateTime.t
        [@ocaml.doc "<p>Date the bucket was created.</p>"]}[@@ocaml.doc
                                                             "<p> In terms of implementation, a Bucket is a resource. An Amazon S3 bucket name is globally unique, and the namespace is shared by all AWS accounts. </p>"]
    let make ~name  ~creation_date  () = { name; creation_date }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("creation_date", (DateTime.to_json v.creation_date));
           Some ("name", (String.to_json v.name))])
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
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @
           [Some
              (Ezxmlm.make_tag "CreationDate"
                 ([], (DateTime.to_xml v.creation_date)))])
  end[@@ocaml.doc
       "<p> In terms of implementation, a Bucket is a resource. An Amazon S3 bucket name is globally unique, and the namespace is shared by all AWS accounts. </p>"]
module CloudFunctionConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      event: Event.t option ;
      events: EventList.t
        [@ocaml.doc "<p>Bucket events for which to send notifications.</p>"];
      cloud_function: String.t option
        [@ocaml.doc
          "<p>Lambda cloud function ARN that Amazon S3 can invoke when it detects events of the specified type.</p>"];
      invocation_role: String.t option
        [@ocaml.doc
          "<p>The role supporting the invocation of the Lambda function</p>"]}
    [@@ocaml.doc
      "<p>Container for specifying the AWS Lambda notification configuration.</p>"]
    let make ?id  ?event  ?(events= [])  ?cloud_function  ?invocation_role 
      () = { id; event; events; cloud_function; invocation_role }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Container for specifying the AWS Lambda notification configuration.</p>"]
module QueueConfigurationDeprecated =
  struct
    type t =
      {
      id: String.t option ;
      event: Event.t option ;
      events: EventList.t
        [@ocaml.doc
          "<p>A collection of bucket events for which to send notifications</p>"];
      queue: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3 publishes a message when it detects events of the specified type. </p>"]}
    [@@ocaml.doc
      "<p>This data type is deprecated. Use <a>QueueConfiguration</a> for the same purposes. This data type specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events. </p>"]
    let make ?id  ?event  ?(events= [])  ?queue  () =
      { id; event; events; queue }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.queue (fun f -> ("queue", (String.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Util.option_map v.event (fun f -> ("event", (Event.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          event = (Util.option_bind (Xml.member "Event" xml) Event.parse);
          events = (Util.of_option [] (EventList.parse xml));
          queue = (Util.option_bind (Xml.member "Queue" xml) String.parse)
        }
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
  end[@@ocaml.doc
       "<p>This data type is deprecated. Use <a>QueueConfiguration</a> for the same purposes. This data type specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events. </p>"]
module TopicConfigurationDeprecated =
  struct
    type t =
      {
      id: String.t option ;
      events: EventList.t
        [@ocaml.doc "<p>A collection of events related to objects</p>"];
      event: Event.t option
        [@ocaml.doc "<p>Bucket event for which to send notifications.</p>"];
      topic: String.t option
        [@ocaml.doc
          "<p>Amazon SNS topic to which Amazon S3 will publish a message to report the specified events for the bucket.</p>"]}
    [@@ocaml.doc
      "<p>A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events. This data type is deprecated. Use <a>TopicConfiguration</a> instead.</p>"]
    let make ?id  ?(events= [])  ?event  ?topic  () =
      { id; events; event; topic }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.topic (fun f -> ("topic", (String.to_json f)));
           Util.option_map v.event (fun f -> ("event", (Event.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          events = (Util.of_option [] (EventList.parse xml));
          event = (Util.option_bind (Xml.member "Event" xml) Event.parse);
          topic = (Util.option_bind (Xml.member "Topic" xml) String.parse)
        }
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
  end[@@ocaml.doc
       "<p>A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events. This data type is deprecated. Use <a>TopicConfiguration</a> instead.</p>"]
module ContinuationEvent =
  struct
    type t = unit[@@ocaml.doc "<p/>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p/>"]
module EndEvent =
  struct
    type t = unit[@@ocaml.doc
                   "<p>A message that indicates the request is complete and no more messages will be sent. You should not assume that the request is complete until the client receives an <code>EndEvent</code>.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc
       "<p>A message that indicates the request is complete and no more messages will be sent. You should not assume that the request is complete until the client receives an <code>EndEvent</code>.</p>"]
module ProgressEvent =
  struct
    type t =
      {
      details: Progress.t option
        [@ocaml.doc "<p>The Progress event details.</p>"]}[@@ocaml.doc
                                                            "<p>This data type contains information about the progress event of an operation.</p>"]
    let make ?details  () = { details }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (Progress.to_json f)))])
    let parse xml =
      Some
        {
          details =
            (Util.option_bind (Xml.member "Details" xml) Progress.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.details
              (fun f -> Ezxmlm.make_tag "Details" ([], (Progress.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type contains information about the progress event of an operation.</p>"]
module RecordsEvent =
  struct
    type t =
      {
      payload: Blob.t option
        [@ocaml.doc
          "<p>The byte array of partial, one or more result records.</p>"]}
    [@@ocaml.doc "<p>The container for the records event.</p>"]
    let make ?payload  () = { payload }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.payload
              (fun f -> ("payload", (Blob.to_json f)))])
    let parse xml =
      Some
        { payload = (Util.option_bind (Xml.member "Payload" xml) Blob.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.payload
              (fun f -> Ezxmlm.make_tag "Payload" ([], (Blob.to_xml f)))])
  end[@@ocaml.doc "<p>The container for the records event.</p>"]
module StatsEvent =
  struct
    type t =
      {
      details: Stats.t option [@ocaml.doc "<p>The Stats event details.</p>"]}
    [@@ocaml.doc "<p>Container for the Stats Event.</p>"]
    let make ?details  () = { details }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (Stats.to_json f)))])
    let parse xml =
      Some
        { details = (Util.option_bind (Xml.member "Details" xml) Stats.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.details
              (fun f -> Ezxmlm.make_tag "Details" ([], (Stats.to_xml f)))])
  end[@@ocaml.doc "<p>Container for the Stats Event.</p>"]
module DeletedObject =
  struct
    type t =
      {
      key: String.t option
        [@ocaml.doc "<p>The name of the deleted object.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>The version ID of the deleted object.</p>"];
      delete_marker: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker. In a simple DELETE, this header indicates whether (true) or not (false) a delete marker was created.</p>"];
      delete_marker_version_id: String.t option
        [@ocaml.doc
          "<p>The version ID of the delete marker created as a result of the DELETE operation. If you delete a specific object version, the value returned by this header is the version ID of the object version deleted.</p>"]}
    [@@ocaml.doc "<p>Information about the deleted object.</p>"]
    let make ?key  ?version_id  ?delete_marker  ?delete_marker_version_id  ()
      = { key; version_id; delete_marker; delete_marker_version_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc "<p>Information about the deleted object.</p>"]
module Error =
  struct
    type t =
      {
      key: String.t option [@ocaml.doc "<p>The error key.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>The version ID of the error.</p>"];
      code: String.t option
        [@ocaml.doc
          "<p>The error code is a string that uniquely identifies an error condition. It is meant to be read and understood by programs that detect and handle errors by type. </p> <p class=\"title\"> <b>Amazon S3 error codes</b> </p> <ul> <li> <ul> <li> <p> <i>Code:</i> AccessDenied </p> </li> <li> <p> <i>Description:</i> Access Denied</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AccountProblem</p> </li> <li> <p> <i>Description:</i> There is a problem with your AWS account that prevents the operation from completing successfully. Contact AWS Support for further assistance.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AllAccessDisabled</p> </li> <li> <p> <i>Description:</i> All access to this Amazon S3 resource has been disabled. Contact AWS Support for further assistance.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AmbiguousGrantByEmailAddress</p> </li> <li> <p> <i>Description:</i> The email address you provided is associated with more than one account.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> AuthorizationHeaderMalformed</p> </li> <li> <p> <i>Description:</i> The authorization header you provided is invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>HTTP Status Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BadDigest</p> </li> <li> <p> <i>Description:</i> The Content-MD5 you specified did not match what we received.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BucketAlreadyExists</p> </li> <li> <p> <i>Description:</i> The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BucketAlreadyOwnedByYou</p> </li> <li> <p> <i>Description:</i> The bucket you tried to create already exists, and you own it. Amazon S3 returns this error in all AWS Regions except in the North Virginia Region. For legacy compatibility, if you re-create an existing bucket that you already own in the North Virginia Region, Amazon S3 returns 200 OK and resets the bucket access control lists (ACLs).</p> </li> <li> <p> <i>Code:</i> 409 Conflict (in all Regions except the North Virginia Region) </p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> BucketNotEmpty</p> </li> <li> <p> <i>Description:</i> The bucket you tried to delete is not empty.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> CredentialsNotSupported</p> </li> <li> <p> <i>Description:</i> This request does not support credentials.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> CrossLocationLoggingProhibited</p> </li> <li> <p> <i>Description:</i> Cross-location logging not allowed. Buckets in one geographic location cannot log information to a bucket in another location.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> EntityTooSmall</p> </li> <li> <p> <i>Description:</i> Your proposed upload is smaller than the minimum allowed object size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> EntityTooLarge</p> </li> <li> <p> <i>Description:</i> Your proposed upload exceeds the maximum allowed object size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> ExpiredToken</p> </li> <li> <p> <i>Description:</i> The provided token has expired.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> IllegalVersioningConfigurationException </p> </li> <li> <p> <i>Description:</i> Indicates that the versioning configuration specified in the request is invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> IncompleteBody</p> </li> <li> <p> <i>Description:</i> You did not provide the number of bytes specified by the Content-Length HTTP header</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> IncorrectNumberOfFilesInPostRequest</p> </li> <li> <p> <i>Description:</i> POST requires exactly one file upload per request.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InlineDataTooLarge</p> </li> <li> <p> <i>Description:</i> Inline data exceeds the maximum allowed size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InternalError</p> </li> <li> <p> <i>Description:</i> We encountered an internal error. Please try again.</p> </li> <li> <p> <i>HTTP Status Code:</i> 500 Internal Server Error</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidAccessKeyId</p> </li> <li> <p> <i>Description:</i> The AWS access key ID you provided does not exist in our records.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidAddressingHeader</p> </li> <li> <p> <i>Description:</i> You must specify the Anonymous role.</p> </li> <li> <p> <i>HTTP Status Code:</i> N/A</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidArgument</p> </li> <li> <p> <i>Description:</i> Invalid Argument</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidBucketName</p> </li> <li> <p> <i>Description:</i> The specified bucket is not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidBucketState</p> </li> <li> <p> <i>Description:</i> The request is not valid with the current state of the bucket.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidDigest</p> </li> <li> <p> <i>Description:</i> The Content-MD5 you specified is not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidEncryptionAlgorithmError</p> </li> <li> <p> <i>Description:</i> The encryption request you specified is not valid. The valid value is AES256.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidLocationConstraint</p> </li> <li> <p> <i>Description:</i> The specified location constraint is not valid. For more information about Regions, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro\">How to Select a Region for Your Buckets</a>. </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidObjectState</p> </li> <li> <p> <i>Description:</i> The operation is not valid for the current state of the object.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPart</p> </li> <li> <p> <i>Description:</i> One or more of the specified parts could not be found. The part might not have been uploaded, or the specified entity tag might not have matched the part's entity tag.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPartOrder</p> </li> <li> <p> <i>Description:</i> The list of parts was not in ascending order. Parts list must be specified in order by part number.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPayer</p> </li> <li> <p> <i>Description:</i> All access to this object has been disabled. Please contact AWS Support for further assistance.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidPolicyDocument</p> </li> <li> <p> <i>Description:</i> The content of the form does not meet the conditions specified in the policy document.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRange</p> </li> <li> <p> <i>Description:</i> The requested range cannot be satisfied.</p> </li> <li> <p> <i>HTTP Status Code:</i> 416 Requested Range Not Satisfiable</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Please use AWS4-HMAC-SHA256.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> SOAP requests must be made over an HTTPS connection.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration is not supported for buckets with non-DNS compliant names.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration is not supported for buckets with periods (.) in their names.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Accelerate endpoint only supports virtual style requests.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Accelerate is not configured on this bucket.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Accelerate is disabled on this bucket.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration is not supported on this bucket. Contact AWS Support for more information.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidRequest</p> </li> <li> <p> <i>Description:</i> Amazon S3 Transfer Acceleration cannot be enabled on this bucket. Contact AWS Support for more information.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>Code:</i> N/A</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidSecurity</p> </li> <li> <p> <i>Description:</i> The provided security credentials are not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidSOAPRequest</p> </li> <li> <p> <i>Description:</i> The SOAP request body is invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidStorageClass</p> </li> <li> <p> <i>Description:</i> The storage class you specified is not valid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidTargetBucketForLogging</p> </li> <li> <p> <i>Description:</i> The target bucket for logging does not exist, is not owned by you, or does not have the appropriate grants for the log-delivery group. </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidToken</p> </li> <li> <p> <i>Description:</i> The provided token is malformed or otherwise invalid.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> InvalidURI</p> </li> <li> <p> <i>Description:</i> Couldn't parse the specified URI.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> KeyTooLongError</p> </li> <li> <p> <i>Description:</i> Your key is too long.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MalformedACLError</p> </li> <li> <p> <i>Description:</i> The XML you provided was not well-formed or did not validate against our published schema.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MalformedPOSTRequest </p> </li> <li> <p> <i>Description:</i> The body of your POST request is not well-formed multipart/form-data.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MalformedXML</p> </li> <li> <p> <i>Description:</i> This happens when the user sends malformed XML (XML that doesn't conform to the published XSD) for the configuration. The error message is, \"The XML you provided was not well-formed or did not validate against our published schema.\" </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MaxMessageLengthExceeded</p> </li> <li> <p> <i>Description:</i> Your request was too big.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MaxPostPreDataLengthExceededError</p> </li> <li> <p> <i>Description:</i> Your POST request fields preceding the upload file were too large.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MetadataTooLarge</p> </li> <li> <p> <i>Description:</i> Your metadata headers exceed the maximum allowed metadata size.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MethodNotAllowed</p> </li> <li> <p> <i>Description:</i> The specified method is not allowed against this resource.</p> </li> <li> <p> <i>HTTP Status Code:</i> 405 Method Not Allowed</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingAttachment</p> </li> <li> <p> <i>Description:</i> A SOAP attachment was expected, but none were found.</p> </li> <li> <p> <i>HTTP Status Code:</i> N/A</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingContentLength</p> </li> <li> <p> <i>Description:</i> You must provide the Content-Length HTTP header.</p> </li> <li> <p> <i>HTTP Status Code:</i> 411 Length Required</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingRequestBodyError</p> </li> <li> <p> <i>Description:</i> This happens when the user sends an empty XML document as a request. The error message is, \"Request body is empty.\" </p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingSecurityElement</p> </li> <li> <p> <i>Description:</i> The SOAP 1.1 request is missing a security element.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> MissingSecurityHeader</p> </li> <li> <p> <i>Description:</i> Your request is missing a required header.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoLoggingStatusForKey</p> </li> <li> <p> <i>Description:</i> There is no such thing as a logging status subresource for a key.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchBucket</p> </li> <li> <p> <i>Description:</i> The specified bucket does not exist.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchBucketPolicy</p> </li> <li> <p> <i>Description:</i> The specified bucket does not have a bucket policy.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchKey</p> </li> <li> <p> <i>Description:</i> The specified key does not exist.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchLifecycleConfiguration</p> </li> <li> <p> <i>Description:</i> The lifecycle configuration does not exist. </p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchUpload</p> </li> <li> <p> <i>Description:</i> The specified multipart upload does not exist. The upload ID might be invalid, or the multipart upload might have been aborted or completed.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NoSuchVersion </p> </li> <li> <p> <i>Description:</i> Indicates that the version ID specified in the request does not match an existing version.</p> </li> <li> <p> <i>HTTP Status Code:</i> 404 Not Found</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NotImplemented</p> </li> <li> <p> <i>Description:</i> A header you provided implies functionality that is not implemented.</p> </li> <li> <p> <i>HTTP Status Code:</i> 501 Not Implemented</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> NotSignedUp</p> </li> <li> <p> <i>Description:</i> Your account is not signed up for the Amazon S3 service. You must sign up before you can use Amazon S3. You can sign up at the following URL: https://aws.amazon.com/s3</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> OperationAborted</p> </li> <li> <p> <i>Description:</i> A conflicting conditional operation is currently in progress against this resource. Try again.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> PermanentRedirect</p> </li> <li> <p> <i>Description:</i> The bucket you are attempting to access must be addressed using the specified endpoint. Send all future requests to this endpoint.</p> </li> <li> <p> <i>HTTP Status Code:</i> 301 Moved Permanently</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> PreconditionFailed</p> </li> <li> <p> <i>Description:</i> At least one of the preconditions you specified did not hold.</p> </li> <li> <p> <i>HTTP Status Code:</i> 412 Precondition Failed</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> Redirect</p> </li> <li> <p> <i>Description:</i> Temporary redirect.</p> </li> <li> <p> <i>HTTP Status Code:</i> 307 Moved Temporarily</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RestoreAlreadyInProgress</p> </li> <li> <p> <i>Description:</i> Object restore is already in progress.</p> </li> <li> <p> <i>HTTP Status Code:</i> 409 Conflict</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestIsNotMultiPartContent</p> </li> <li> <p> <i>Description:</i> Bucket POST must be of the enclosure-type multipart/form-data.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestTimeout</p> </li> <li> <p> <i>Description:</i> Your socket connection to the server was not read from or written to within the timeout period.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestTimeTooSkewed</p> </li> <li> <p> <i>Description:</i> The difference between the request time and the server's time is too large.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> RequestTorrentOfBucketError</p> </li> <li> <p> <i>Description:</i> Requesting the torrent file of a bucket is not permitted.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> SignatureDoesNotMatch</p> </li> <li> <p> <i>Description:</i> The request signature we calculated does not match the signature you provided. Check your AWS secret access key and signing method. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html\">REST Authentication</a> and <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/SOAPAuthentication.html\">SOAP Authentication</a> for details.</p> </li> <li> <p> <i>HTTP Status Code:</i> 403 Forbidden</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> ServiceUnavailable</p> </li> <li> <p> <i>Description:</i> Reduce your request rate.</p> </li> <li> <p> <i>HTTP Status Code:</i> 503 Service Unavailable</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> SlowDown</p> </li> <li> <p> <i>Description:</i> Reduce your request rate.</p> </li> <li> <p> <i>HTTP Status Code:</i> 503 Slow Down</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Server</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> TemporaryRedirect</p> </li> <li> <p> <i>Description:</i> You are being redirected to the bucket while DNS updates.</p> </li> <li> <p> <i>HTTP Status Code:</i> 307 Moved Temporarily</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> TokenRefreshRequired</p> </li> <li> <p> <i>Description:</i> The provided token must be refreshed.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> TooManyBuckets</p> </li> <li> <p> <i>Description:</i> You have attempted to create more buckets than allowed.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> UnexpectedContent</p> </li> <li> <p> <i>Description:</i> This request does not support content.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> UnresolvableGrantByEmailAddress</p> </li> <li> <p> <i>Description:</i> The email address you provided does not match any account on record.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> <li> <ul> <li> <p> <i>Code:</i> UserKeyMustBeSpecified</p> </li> <li> <p> <i>Description:</i> The bucket POST must contain the specified field name. If it is specified, check the order of the fields.</p> </li> <li> <p> <i>HTTP Status Code:</i> 400 Bad Request</p> </li> <li> <p> <i>SOAP Fault Code Prefix:</i> Client</p> </li> </ul> </li> </ul> <p/>"];
      message: String.t option
        [@ocaml.doc
          "<p>The error message contains a generic description of the error condition in English. It is intended for a human audience. Simple programs display the message directly to the end user if they encounter an error condition they don't know how or don't care to handle. Sophisticated programs with more exhaustive error handling and proper internationalization are more likely to ignore the error message.</p>"]}
    [@@ocaml.doc "<p>Container for all error elements.</p>"]
    let make ?key  ?version_id  ?code  ?message  () =
      { key; version_id; code; message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)));
           Util.option_map v.code (fun f -> ("code", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
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
  end[@@ocaml.doc "<p>Container for all error elements.</p>"]
module LifecycleRules =
  struct
    type t = LifecycleRule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list LifecycleRule.to_query v
    let to_headers v = Headers.to_headers_list LifecycleRule.to_headers v
    let to_json v = `List (List.map LifecycleRule.to_json v)
    let parse xml = Util.option_all (List.map LifecycleRule.parse [xml])
    let to_xml v = List.concat (List.map LifecycleRule.to_xml v)
  end
module Part =
  struct
    type t =
      {
      part_number: Integer.t option
        [@ocaml.doc
          "<p>Part number identifying the part. This is a positive integer between 1 and 10,000.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc "<p>Date and time at which the part was uploaded.</p>"];
      e_tag: String.t option
        [@ocaml.doc "<p>Entity tag returned when the part was uploaded.</p>"];
      size: Integer.t option
        [@ocaml.doc "<p>Size in bytes of the uploaded part data.</p>"]}
    [@@ocaml.doc "<p>Container for elements related to a part.</p>"]
    let make ?part_number  ?last_modified  ?e_tag  ?size  () =
      { part_number; last_modified; e_tag; size }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.size (fun f -> ("size", (Integer.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)));
           Util.option_map v.last_modified
             (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.part_number
             (fun f -> ("part_number", (Integer.to_json f)))])
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
  end[@@ocaml.doc "<p>Container for elements related to a part.</p>"]
module MultipartUpload =
  struct
    type t =
      {
      upload_id: String.t option
        [@ocaml.doc "<p>Upload ID that identifies the multipart upload.</p>"];
      key: String.t option
        [@ocaml.doc
          "<p>Key of the object for which the multipart upload was initiated.</p>"];
      initiated: DateTime.t option
        [@ocaml.doc
          "<p>Date and time at which the multipart upload was initiated.</p>"];
      storage_class: StorageClass.t option
        [@ocaml.doc "<p>The class of storage used to store the object.</p>"];
      owner: Owner.t option
        [@ocaml.doc
          "<p>Specifies the owner of the object that is part of the multipart upload. </p>"];
      initiator: Initiator.t option
        [@ocaml.doc "<p>Identifies who initiated the multipart upload.</p>"]}
    [@@ocaml.doc
      "<p>Container for the <code>MultipartUpload</code> for the Amazon S3 object.</p>"]
    let make ?upload_id  ?key  ?initiated  ?storage_class  ?owner  ?initiator
       () = { upload_id; key; initiated; storage_class; owner; initiator }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Container for the <code>MultipartUpload</code> for the Amazon S3 object.</p>"]
module LambdaFunctionConfigurationList =
  struct
    type t = LambdaFunctionConfiguration.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list LambdaFunctionConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list LambdaFunctionConfiguration.to_headers v
    let to_json v = `List (List.map LambdaFunctionConfiguration.to_json v)
    let parse xml =
      Util.option_all (List.map LambdaFunctionConfiguration.parse [xml])
    let to_xml v =
      List.concat (List.map LambdaFunctionConfiguration.to_xml v)
  end
module QueueConfigurationList =
  struct
    type t = QueueConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list QueueConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list QueueConfiguration.to_headers v
    let to_json v = `List (List.map QueueConfiguration.to_json v)
    let parse xml = Util.option_all (List.map QueueConfiguration.parse [xml])
    let to_xml v = List.concat (List.map QueueConfiguration.to_xml v)
  end
module TopicConfigurationList =
  struct
    type t = TopicConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TopicConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list TopicConfiguration.to_headers v
    let to_json v = `List (List.map TopicConfiguration.to_json v)
    let parse xml = Util.option_all (List.map TopicConfiguration.parse [xml])
    let to_xml v = List.concat (List.map TopicConfiguration.to_xml v)
  end
module CommonPrefixList =
  struct
    type t = CommonPrefix.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CommonPrefix.to_query v
    let to_headers v = Headers.to_headers_list CommonPrefix.to_headers v
    let to_json v = `List (List.map CommonPrefix.to_json v)
    let parse xml = Util.option_all (List.map CommonPrefix.parse [xml])
    let to_xml v = List.concat (List.map CommonPrefix.to_xml v)
  end
module EncodingType =
  struct
    type t =
      | Url [@@ocaml.doc
              "<p>Requests Amazon S3 to encode the object keys in the response and specifies the encoding method to use. An object key may contain any Unicode character; however, XML 1.0 parser cannot parse some characters, such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request that Amazon S3 encode the keys in the response.</p>"]
    let str_to_t = [("url", Url)]
    let t_to_str = [(Url, "url")]
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
  end[@@ocaml.doc
       "<p>Requests Amazon S3 to encode the object keys in the response and specifies the encoding method to use. An object key may contain any Unicode character; however, XML 1.0 parser cannot parse some characters, such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request that Amazon S3 encode the keys in the response.</p>"]
module ObjectList =
  struct
    type t = Object.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Object.to_query v
    let to_headers v = Headers.to_headers_list Object.to_headers v
    let to_json v = `List (List.map Object.to_json v)
    let parse xml = Util.option_all (List.map Object.parse [xml])
    let to_xml v = List.concat (List.map Object.to_xml v)
  end
module RequestPayer =
  struct
    type t =
      | Requester [@@ocaml.doc
                    "<p>Confirms that the requester knows that they will be charged for the request. Bucket owners need not specify this parameter in their requests. For information about downloading objects from requester pays buckets, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectsinRequesterPaysBuckets.html\">Downloading Objects in Requestor Pays Buckets</a> in the <i>Amazon S3 Developer Guide</i>.</p>"]
    let str_to_t = [("requester", Requester)]
    let t_to_str = [(Requester, "requester")]
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
  end[@@ocaml.doc
       "<p>Confirms that the requester knows that they will be charged for the request. Bucket owners need not specify this parameter in their requests. For information about downloading objects from requester pays buckets, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectsinRequesterPaysBuckets.html\">Downloading Objects in Requestor Pays Buckets</a> in the <i>Amazon S3 Developer Guide</i>.</p>"]
module RequestCharged =
  struct
    type t =
      | Requester [@@ocaml.doc
                    "<p>If present, indicates that the requester was successfully charged for the request.</p>"]
    let str_to_t = [("requester", Requester)]
    let t_to_str = [(Requester, "requester")]
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
  end[@@ocaml.doc
       "<p>If present, indicates that the requester was successfully charged for the request.</p>"]
module PolicyStatus =
  struct
    type t =
      {
      is_public: Boolean.t option
        [@ocaml.doc
          "<p>The policy status for this bucket. <code>TRUE</code> indicates that this bucket is public. <code>FALSE</code> indicates that the bucket is not public.</p>"]}
    [@@ocaml.doc
      "<p>The container element for a bucket's policy status.</p>"]
    let make ?is_public  () = { is_public }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_public
              (fun f -> ("is_public", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          is_public =
            (Util.option_bind (Xml.member "IsPublic" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.is_public
              (fun f -> Ezxmlm.make_tag "IsPublic" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>The container element for a bucket's policy status.</p>"]
module ReplicationConfiguration =
  struct
    type t =
      {
      role: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that Amazon S3 assumes when replicating objects. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-how-setup.html\">How to Set Up Replication</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      rules: ReplicationRules.t
        [@ocaml.doc
          "<p>A container for one or more replication rules. A replication configuration must have at least one rule and can contain a maximum of 1,000 rules. </p>"]}
    [@@ocaml.doc
      "<p>A container for replication rules. You can add up to 1,000 rules. The maximum size of a replication configuration is 2 MB.</p>"]
    let make ~role  ~rules  () = { role; rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (ReplicationRules.to_json v.rules));
           Some ("role", (String.to_json v.role))])
    let parse xml =
      Some
        {
          role =
            (Xml.required "Role"
               (Util.option_bind (Xml.member "Role" xml) String.parse));
          rules = (Xml.required "Rule" (ReplicationRules.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Role" ([], (String.to_xml v.role)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule"
                      ([], (ReplicationRules.to_xml [x])))) v.rules))
  end[@@ocaml.doc
       "<p>A container for replication rules. You can add up to 1,000 rules. The maximum size of a replication configuration is 2 MB.</p>"]
module ServerSideEncryptionConfiguration =
  struct
    type t =
      {
      rules: ServerSideEncryptionRules.t
        [@ocaml.doc
          "<p>Container for information about a particular server-side encryption configuration rule.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the default server-side-encryption configuration.</p>"]
    let make ~rules  () = { rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (ServerSideEncryptionRules.to_json v.rules))])
    let parse xml =
      Some
        { rules = (Xml.required "Rule" (ServerSideEncryptionRules.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule"
                      ([], (ServerSideEncryptionRules.to_xml [x])))) v.rules))
  end[@@ocaml.doc
       "<p>Specifies the default server-side-encryption configuration.</p>"]
module LifecycleConfiguration =
  struct
    type t =
      {
      rules: Rules.t
        [@ocaml.doc
          "<p>Specifies lifecycle configuration rules for an Amazon S3 bucket. </p>"]}
    [@@ocaml.doc
      "<p>Container for lifecycle rules. You can add as many as 1000 rules.</p>"]
    let make ~rules  () = { rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("rules", (Rules.to_json v.rules))])
    let parse xml = Some { rules = (Xml.required "Rule" (Rules.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Rule" ([], (Rules.to_xml [x]))))
              v.rules))
  end[@@ocaml.doc
       "<p>Container for lifecycle rules. You can add as many as 1000 rules.</p>"]
module AnalyticsConfigurationList =
  struct
    type t = AnalyticsConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AnalyticsConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list AnalyticsConfiguration.to_headers v
    let to_json v = `List (List.map AnalyticsConfiguration.to_json v)
    let parse xml =
      Util.option_all (List.map AnalyticsConfiguration.parse [xml])
    let to_xml v = List.concat (List.map AnalyticsConfiguration.to_xml v)
  end
module RestoreRequest =
  struct
    type t =
      {
      days: Integer.t option
        [@ocaml.doc
          "<p>Lifetime of the active copy in days. Do not use with restores that specify <code>OutputLocation</code>.</p>"];
      glacier_job_parameters: GlacierJobParameters.t option
        [@ocaml.doc
          "<p>Glacier related parameters pertaining to this job. Do not use with restores that specify <code>OutputLocation</code>.</p>"];
      type_: RestoreRequestType.t option
        [@ocaml.doc "<p>Type of restore request.</p>"];
      tier: Tier.t option
        [@ocaml.doc
          "<p>Glacier retrieval tier at which the restore will be processed.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The optional description for the job.</p>"];
      select_parameters: SelectParameters.t option
        [@ocaml.doc "<p>Describes the parameters for Select job types.</p>"];
      output_location: OutputLocation.t option
        [@ocaml.doc
          "<p>Describes the location where the restore job's output is stored.</p>"]}
    [@@ocaml.doc "<p>Container for restore job parameters.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc "<p>Container for restore job parameters.</p>"]
module DeleteMarkers =
  struct
    type t = DeleteMarkerEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DeleteMarkerEntry.to_query v
    let to_headers v = Headers.to_headers_list DeleteMarkerEntry.to_headers v
    let to_json v = `List (List.map DeleteMarkerEntry.to_json v)
    let parse xml = Util.option_all (List.map DeleteMarkerEntry.parse [xml])
    let to_xml v = List.concat (List.map DeleteMarkerEntry.to_xml v)
  end
module ObjectVersionList =
  struct
    type t = ObjectVersion.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ObjectVersion.to_query v
    let to_headers v = Headers.to_headers_list ObjectVersion.to_headers v
    let to_json v = `List (List.map ObjectVersion.to_json v)
    let parse xml = Util.option_all (List.map ObjectVersion.parse [xml])
    let to_xml v = List.concat (List.map ObjectVersion.to_xml v)
  end
module VersioningConfiguration =
  struct
    type t =
      {
      m_f_a_delete: MFADelete.t option
        [@ocaml.doc
          "<p>Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.</p>"];
      status: BucketVersioningStatus.t option
        [@ocaml.doc "<p>The versioning state of the bucket.</p>"]}[@@ocaml.doc
                                                                    "<p>Describes the versioning state of an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html\">PUT Bucket versioning</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
    let make ?m_f_a_delete  ?status  () = { m_f_a_delete; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (BucketVersioningStatus.to_json f)));
           Util.option_map v.m_f_a_delete
             (fun f -> ("m_f_a_delete", (MFADelete.to_json f)))])
    let parse xml =
      Some
        {
          m_f_a_delete =
            (Util.option_bind (Xml.member "MfaDelete" xml) MFADelete.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               BucketVersioningStatus.parse)
        }
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
  end[@@ocaml.doc
       "<p>Describes the versioning state of an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html\">PUT Bucket versioning</a> in the <i>Amazon Simple Storage Service API Reference</i>.</p>"]
module RequestPaymentConfiguration =
  struct
    type t =
      {
      payer: Payer.t
        [@ocaml.doc
          "<p>Specifies who pays for the download and request fees.</p>"]}
    [@@ocaml.doc "<p>Container for Payer.</p>"]
    let make ~payer  () = { payer }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("payer", (Payer.to_json v.payer))])
    let parse xml =
      Some
        {
          payer =
            (Xml.required "Payer"
               (Util.option_bind (Xml.member "Payer" xml) Payer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Payer" ([], (Payer.to_xml v.payer)))])
  end[@@ocaml.doc "<p>Container for Payer.</p>"]
module ObjectLockConfiguration =
  struct
    type t =
      {
      object_lock_enabled: ObjectLockEnabled.t option
        [@ocaml.doc
          "<p>Indicates whether this bucket has an Object Lock configuration enabled.</p>"];
      rule: ObjectLockRule.t option
        [@ocaml.doc
          "<p>The Object Lock rule in place for the specified object.</p>"]}
    [@@ocaml.doc
      "<p>The container element for Object Lock configuration parameters.</p>"]
    let make ?object_lock_enabled  ?rule  () = { object_lock_enabled; rule }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.rule
              (fun f -> ("rule", (ObjectLockRule.to_json f)));
           Util.option_map v.object_lock_enabled
             (fun f -> ("object_lock_enabled", (ObjectLockEnabled.to_json f)))])
    let parse xml =
      Some
        {
          object_lock_enabled =
            (Util.option_bind (Xml.member "ObjectLockEnabled" xml)
               ObjectLockEnabled.parse);
          rule =
            (Util.option_bind (Xml.member "Rule" xml) ObjectLockRule.parse)
        }
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
  end[@@ocaml.doc
       "<p>The container element for Object Lock configuration parameters.</p>"]
module Delete =
  struct
    type t =
      {
      objects: ObjectIdentifierList.t
        [@ocaml.doc "<p>The objects to delete.</p>"];
      quiet: Boolean.t option
        [@ocaml.doc
          "<p>Element to enable quiet mode for the request. When you add this element, you must set its value to true.</p>"]}
    [@@ocaml.doc "<p>Container for the objects to delete.</p>"]
    let make ~objects  ?quiet  () = { objects; quiet }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.quiet (fun f -> ("quiet", (Boolean.to_json f)));
           Some ("objects", (ObjectIdentifierList.to_json v.objects))])
    let parse xml =
      Some
        {
          objects = (Xml.required "Object" (ObjectIdentifierList.parse xml));
          quiet = (Util.option_bind (Xml.member "Quiet" xml) Boolean.parse)
        }
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
  end[@@ocaml.doc "<p>Container for the objects to delete.</p>"]
module InventoryConfigurationList =
  struct
    type t = InventoryConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryConfiguration.to_headers v
    let to_json v = `List (List.map InventoryConfiguration.to_json v)
    let parse xml =
      Util.option_all (List.map InventoryConfiguration.parse [xml])
    let to_xml v = List.concat (List.map InventoryConfiguration.to_xml v)
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
module Metadata =
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
module WebsiteConfiguration =
  struct
    type t =
      {
      error_document: ErrorDocument.t option
        [@ocaml.doc "<p>The name of the error document for the website.</p>"];
      index_document: IndexDocument.t option
        [@ocaml.doc "<p>The name of the index document for the website.</p>"];
      redirect_all_requests_to: RedirectAllRequestsTo.t option
        [@ocaml.doc
          "<p>The redirect behavior for every request to this bucket's website endpoint.</p> <important> <p>If you specify this property, you can't specify any other property.</p> </important>"];
      routing_rules: RoutingRules.t
        [@ocaml.doc
          "<p>Rules that define when a redirect is applied and the redirect behavior.</p>"]}
    [@@ocaml.doc
      "<p>Specifies website configuration parameters for an Amazon S3 bucket.</p>"]
    let make ?error_document  ?index_document  ?redirect_all_requests_to 
      ?(routing_rules= [])  () =
      {
        error_document;
        index_document;
        redirect_all_requests_to;
        routing_rules
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Specifies website configuration parameters for an Amazon S3 bucket.</p>"]
module PublicAccessBlockConfiguration =
  struct
    type t =
      {
      block_public_acls: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether Amazon S3 should block public access control lists (ACLs) for this bucket and objects in this bucket. Setting this element to <code>TRUE</code> causes the following behavior:</p> <ul> <li> <p>PUT Bucket acl and PUT Object acl calls fail if the specified ACL is public.</p> </li> <li> <p>PUT Object calls fail if the request includes a public ACL.</p> </li> <li> <p>PUT Bucket calls fail if the request includes a public ACL.</p> </li> </ul> <p>Enabling this setting doesn't affect existing policies or ACLs.</p>"];
      ignore_public_acls: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether Amazon S3 should ignore public ACLs for this bucket and objects in this bucket. Setting this element to <code>TRUE</code> causes Amazon S3 to ignore all public ACLs on this bucket and objects in this bucket.</p> <p>Enabling this setting doesn't affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set.</p>"];
      block_public_policy: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether Amazon S3 should block public bucket policies for this bucket. Setting this element to <code>TRUE</code> causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access. </p> <p>Enabling this setting doesn't affect existing bucket policies.</p>"];
      restrict_public_buckets: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether Amazon S3 should restrict public bucket policies for this bucket. Setting this element to <code>TRUE</code> restricts access to this bucket to only AWS services and authorized users within this account if the bucket has a public policy.</p> <p>Enabling this setting doesn't affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked.</p>"]}
    [@@ocaml.doc
      "<p>The PublicAccessBlock configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\">The Meaning of \"Public\"</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p>"]
    let make ?block_public_acls  ?ignore_public_acls  ?block_public_policy 
      ?restrict_public_buckets  () =
      {
        block_public_acls;
        ignore_public_acls;
        block_public_policy;
        restrict_public_buckets
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>The PublicAccessBlock configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status\">The Meaning of \"Public\"</a> in the <i>Amazon Simple Storage Service Developer Guide</i>. </p>"]
module CORSConfiguration =
  struct
    type t =
      {
      c_o_r_s_rules: CORSRules.t
        [@ocaml.doc
          "<p>A set of origins and methods (cross-origin access that you want to allow). You can add up to 100 rules to the configuration.</p>"]}
    [@@ocaml.doc
      "<p>Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
    let make ~c_o_r_s_rules  () = { c_o_r_s_rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("c_o_r_s_rules", (CORSRules.to_json v.c_o_r_s_rules))])
    let parse xml =
      Some
        { c_o_r_s_rules = (Xml.required "CORSRule" (CORSRules.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CORSRule" ([], (CORSRules.to_xml [x]))))
              v.c_o_r_s_rules))
  end[@@ocaml.doc
       "<p>Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
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
module ObjectLockLegalHold =
  struct
    type t =
      {
      status: ObjectLockLegalHoldStatus.t option
        [@ocaml.doc
          "<p>Indicates whether the specified object has a Legal Hold in place.</p>"]}
    [@@ocaml.doc "<p>A Legal Hold configuration for an object.</p>"]
    let make ?status  () = { status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (ObjectLockLegalHoldStatus.to_json f)))])
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
  end[@@ocaml.doc "<p>A Legal Hold configuration for an object.</p>"]
module AccelerateConfiguration =
  struct
    type t =
      {
      status: BucketAccelerateStatus.t option
        [@ocaml.doc
          "<p>Specifies the transfer acceleration status of the bucket.</p>"]}
    [@@ocaml.doc
      "<p>Configures the transfer acceleration state for an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\">Amazon S3 Transfer Acceleration</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
    let make ?status  () = { status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (BucketAccelerateStatus.to_json f)))])
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               BucketAccelerateStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (BucketAccelerateStatus.to_xml f)))])
  end[@@ocaml.doc
       "<p>Configures the transfer acceleration state for an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html\">Amazon S3 Transfer Acceleration</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
module MetricsConfigurationList =
  struct
    type t = MetricsConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricsConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list MetricsConfiguration.to_headers v
    let to_json v = `List (List.map MetricsConfiguration.to_json v)
    let parse xml =
      Util.option_all (List.map MetricsConfiguration.parse [xml])
    let to_xml v = List.concat (List.map MetricsConfiguration.to_xml v)
  end
module ObjectLockRetention =
  struct
    type t =
      {
      mode: ObjectLockRetentionMode.t option
        [@ocaml.doc
          "<p>Indicates the Retention mode for the specified object.</p>"];
      retain_until_date: DateTime.t option
        [@ocaml.doc
          "<p>The date on which this Object Lock Retention will expire.</p>"]}
    [@@ocaml.doc "<p>A Retention configuration for an object.</p>"]
    let make ?mode  ?retain_until_date  () = { mode; retain_until_date }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.retain_until_date
              (fun f -> ("retain_until_date", (DateTime.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ObjectLockRetentionMode.to_json f)))])
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
  end[@@ocaml.doc "<p>A Retention configuration for an object.</p>"]
module AccessControlPolicy =
  struct
    type t =
      {
      grants: Grants.t [@ocaml.doc "<p>A list of grants.</p>"];
      owner: Owner.t option
        [@ocaml.doc
          "<p>Container for the bucket owner's display name and ID.</p>"]}
    [@@ocaml.doc
      "<p>Contains the elements that set the ACL permissions for an object per grantee.</p>"]
    let make ?(grants= [])  ?owner  () = { grants; owner }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Some ("grants", (Grants.to_json v.grants))])
    let parse xml =
      Some
        {
          grants =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccessControlList" xml)
                  Grants.parse));
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse)
        }
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
  end[@@ocaml.doc
       "<p>Contains the elements that set the ACL permissions for an object per grantee.</p>"]
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
module CreateBucketConfiguration =
  struct
    type t =
      {
      location_constraint: BucketLocationConstraint.t option
        [@ocaml.doc
          "<p>Specifies the Region where the bucket will be created. If you don't specify a Region, the bucket is created in the US East (N. Virginia) Region (us-east-1).</p>"]}
    [@@ocaml.doc "<p>The configuration information for the bucket.</p>"]
    let make ?location_constraint  () = { location_constraint }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.location_constraint
              (fun f ->
                 ("location_constraint",
                   (BucketLocationConstraint.to_json f)))])
    let parse xml =
      Some
        {
          location_constraint =
            (Util.option_bind (Xml.member "LocationConstraint" xml)
               BucketLocationConstraint.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.location_constraint
              (fun f ->
                 Ezxmlm.make_tag "LocationConstraint"
                   ([], (BucketLocationConstraint.to_xml f)))])
  end[@@ocaml.doc "<p>The configuration information for the bucket.</p>"]
module BucketLoggingStatus =
  struct
    type t = {
      logging_enabled: LoggingEnabled.t option }[@@ocaml.doc
                                                  "<p>Container for logging status information.</p>"]
    let make ?logging_enabled  () = { logging_enabled }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.logging_enabled
              (fun f -> ("logging_enabled", (LoggingEnabled.to_json f)))])
    let parse xml =
      Some
        {
          logging_enabled =
            (Util.option_bind (Xml.member "LoggingEnabled" xml)
               LoggingEnabled.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.logging_enabled
              (fun f ->
                 Ezxmlm.make_tag "LoggingEnabled"
                   ([], (LoggingEnabled.to_xml f)))])
  end[@@ocaml.doc "<p>Container for logging status information.</p>"]
module CompletedMultipartUpload =
  struct
    type t =
      {
      parts: CompletedPartList.t
        [@ocaml.doc "<p>Array of CompletedPart data types.</p>"]}[@@ocaml.doc
                                                                   "<p>The container for the completed multipart upload details.</p>"]
    let make ?(parts= [])  () = { parts }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("parts", (CompletedPartList.to_json v.parts))])
    let parse xml =
      Some { parts = (Util.of_option [] (CompletedPartList.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Part"
                      ([], (CompletedPartList.to_xml [x])))) v.parts))
  end[@@ocaml.doc
       "<p>The container for the completed multipart upload details.</p>"]
module Buckets =
  struct
    type t = Bucket.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Bucket.to_query v
    let to_headers v = Headers.to_headers_list Bucket.to_headers v
    let to_json v = `List (List.map Bucket.to_json v)
    let parse xml =
      Util.option_all (List.map Bucket.parse (Xml.members "Bucket" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Bucket.to_xml x))) v
  end
module NotificationConfigurationDeprecated =
  struct
    type t =
      {
      topic_configuration: TopicConfigurationDeprecated.t option
        [@ocaml.doc
          "<p>This data type is deprecated. A container for specifying the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events. </p>"];
      queue_configuration: QueueConfigurationDeprecated.t option
        [@ocaml.doc
          "<p>This data type is deprecated. This data type specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events. </p>"];
      cloud_function_configuration: CloudFunctionConfiguration.t option
        [@ocaml.doc
          "<p>Container for specifying the AWS Lambda notification configuration.</p>"]}
    let make ?topic_configuration  ?queue_configuration 
      ?cloud_function_configuration  () =
      {
        topic_configuration;
        queue_configuration;
        cloud_function_configuration
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module SelectObjectContentEventStream =
  struct
    type t =
      {
      records: RecordsEvent.t option [@ocaml.doc "<p>The Records Event.</p>"];
      stats: StatsEvent.t option [@ocaml.doc "<p>The Stats Event.</p>"];
      progress: ProgressEvent.t option
        [@ocaml.doc "<p>The Progress Event.</p>"];
      cont: ContinuationEvent.t option
        [@ocaml.doc "<p>The Continuation Event.</p>"];
      end_: EndEvent.t option [@ocaml.doc "<p>The End Event.</p>"]}[@@ocaml.doc
                                                                    "<p>The container for selecting objects from a content event stream.</p>"]
    let make ?records  ?stats  ?progress  ?cont  ?end_  () =
      { records; stats; progress; cont; end_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>The container for selecting objects from a content event stream.</p>"]
module RequestProgress =
  struct
    type t =
      {
      enabled: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether periodic QueryProgress frames should be sent. Valid values: TRUE, FALSE. Default value: FALSE.</p>"]}
    [@@ocaml.doc
      "<p>Container for specifying if periodic <code>QueryProgress</code> messages should be sent.</p>"]
    let make ?enabled  () = { enabled }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.enabled
              (fun f -> ("enabled", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          enabled =
            (Util.option_bind (Xml.member "Enabled" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.enabled
              (fun f -> Ezxmlm.make_tag "Enabled" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Container for specifying if periodic <code>QueryProgress</code> messages should be sent.</p>"]
module ScanRange =
  struct
    type t =
      {
      start: Long.t option
        [@ocaml.doc
          "<p>Specifies the start of the byte range. This parameter is optional. Valid values: non-negative integers. The default value is 0. If only start is supplied, it means scan from that point to the end of the file.For example; <code>&lt;scanrange&gt;&lt;start&gt;50&lt;/start&gt;&lt;/scanrange&gt;</code> means scan from byte 50 until the end of the file.</p>"];
      end_: Long.t option
        [@ocaml.doc
          "<p>Specifies the end of the byte range. This parameter is optional. Valid values: non-negative integers. The default value is one less than the size of the object being queried. If only the End parameter is supplied, it is interpreted to mean scan the last N bytes of the file. For example, <code>&lt;scanrange&gt;&lt;end&gt;50&lt;/end&gt;&lt;/scanrange&gt;</code> means scan the last 50 bytes.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the byte range of the object to get the records from. A record is processed when its first byte is contained by the range. This parameter is optional, but when specified, it must not be empty. See RFC 2616, Section 14.35.1 about how to specify the start and end of the range.</p>"]
    let make ?start  ?end_  () = { start; end_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_ (fun f -> ("end_", (Long.to_json f)));
           Util.option_map v.start (fun f -> ("start", (Long.to_json f)))])
    let parse xml =
      Some
        {
          start = (Util.option_bind (Xml.member "Start" xml) Long.parse);
          end_ = (Util.option_bind (Xml.member "End" xml) Long.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.start
               (fun f -> Ezxmlm.make_tag "Start" ([], (Long.to_xml f)))])
           @
           [Util.option_map v.end_
              (fun f -> Ezxmlm.make_tag "End" ([], (Long.to_xml f)))])
  end[@@ocaml.doc
       "<p>Specifies the byte range of the object to get the records from. A record is processed when its first byte is contained by the range. This parameter is optional, but when specified, it must not be empty. See RFC 2616, Section 14.35.1 about how to specify the start and end of the range.</p>"]
module DeletedObjects =
  struct
    type t = DeletedObject.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DeletedObject.to_query v
    let to_headers v = Headers.to_headers_list DeletedObject.to_headers v
    let to_json v = `List (List.map DeletedObject.to_json v)
    let parse xml = Util.option_all (List.map DeletedObject.parse [xml])
    let to_xml v = List.concat (List.map DeletedObject.to_xml v)
  end
module Errors =
  struct
    type t = Error.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Error.to_query v
    let to_headers v = Headers.to_headers_list Error.to_headers v
    let to_json v = `List (List.map Error.to_json v)
    let parse xml = Util.option_all (List.map Error.parse [xml])
    let to_xml v = List.concat (List.map Error.to_xml v)
  end
module CopyPartResult =
  struct
    type t =
      {
      e_tag: String.t option [@ocaml.doc "<p>Entity tag of the object.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc "<p>Date and time at which the object was uploaded.</p>"]}
    [@@ocaml.doc "<p>Container for all response elements.</p>"]
    let make ?e_tag  ?last_modified  () = { e_tag; last_modified }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_modified
              (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)))])
    let parse xml =
      Some
        {
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.e_tag
               (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
           @
           [Util.option_map v.last_modified
              (fun f ->
                 Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc "<p>Container for all response elements.</p>"]
module BucketLifecycleConfiguration =
  struct
    type t =
      {
      rules: LifecycleRules.t
        [@ocaml.doc
          "<p>A lifecycle rule for individual objects in an Amazon S3 bucket.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the lifecycle configuration for objects in an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\">Object Lifecycle Management</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
    let make ~rules  () = { rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (LifecycleRules.to_json v.rules))])
    let parse xml =
      Some { rules = (Xml.required "Rule" (LifecycleRules.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule" ([], (LifecycleRules.to_xml [x]))))
              v.rules))
  end[@@ocaml.doc
       "<p>Specifies the lifecycle configuration for objects in an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html\">Object Lifecycle Management</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"]
module Parts =
  struct
    type t = Part.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Part.to_query v
    let to_headers v = Headers.to_headers_list Part.to_headers v
    let to_json v = `List (List.map Part.to_json v)
    let parse xml = Util.option_all (List.map Part.parse [xml])
    let to_xml v = List.concat (List.map Part.to_xml v)
  end
module MultipartUploadList =
  struct
    type t = MultipartUpload.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MultipartUpload.to_query v
    let to_headers v = Headers.to_headers_list MultipartUpload.to_headers v
    let to_json v = `List (List.map MultipartUpload.to_json v)
    let parse xml = Util.option_all (List.map MultipartUpload.parse [xml])
    let to_xml v = List.concat (List.map MultipartUpload.to_xml v)
  end
module CopyObjectResult =
  struct
    type t =
      {
      e_tag: String.t option
        [@ocaml.doc
          "<p>Returns the ETag of the new object. The ETag reflects only changes to the contents of an object, not its metadata. The source and destination ETag is identical for a successfully copied object.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc
          "<p>Returns the date that the object was last modified.</p>"]}
    [@@ocaml.doc "<p>Container for all response elements.</p>"]
    let make ?e_tag  ?last_modified  () = { e_tag; last_modified }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_modified
              (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)))])
    let parse xml =
      Some
        {
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.e_tag
               (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
           @
           [Util.option_map v.last_modified
              (fun f ->
                 Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc "<p>Container for all response elements.</p>"]
module NotificationConfiguration =
  struct
    type t =
      {
      topic_configurations: TopicConfigurationList.t
        [@ocaml.doc
          "<p>The topic to which notifications are sent and the events for which notifications are generated.</p>"];
      queue_configurations: QueueConfigurationList.t
        [@ocaml.doc
          "<p>The Amazon Simple Queue Service queues to publish messages to and the events for which to publish messages.</p>"];
      lambda_function_configurations: LambdaFunctionConfigurationList.t
        [@ocaml.doc
          "<p>Describes the AWS Lambda functions to invoke and the events for which to invoke them.</p>"]}
    [@@ocaml.doc
      "<p>A container for specifying the notification configuration of the bucket. If this element is empty, notifications are turned off for the bucket.</p>"]
    let make ?(topic_configurations= [])  ?(queue_configurations= []) 
      ?(lambda_function_configurations= [])  () =
      {
        topic_configurations;
        queue_configurations;
        lambda_function_configurations
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>A container for specifying the notification configuration of the bucket. If this element is empty, notifications are turned off for the bucket.</p>"]
module ListObjectsV2Output =
  struct
    type t =
      {
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p>Set to false if all of the results were returned. Set to true if more keys are available to return. If the number of results exceeds that specified by MaxKeys, all of the results might not be returned.</p>"];
      contents: ObjectList.t
        [@ocaml.doc "<p>Metadata about each object returned.</p>"];
      name: String.t option
        [@ocaml.doc
          "<p>Bucket name. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      prefix: String.t option
        [@ocaml.doc "<p> Keys that begin with the indicated prefix.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>Causes keys that contain the same string between the prefix and the first occurrence of the delimiter to be rolled up into a single result element in the CommonPrefixes collection. These rolled-up keys are not returned elsewhere in the response. Each rolled-up result counts as only one return against the <code>MaxKeys</code> value.</p>"];
      max_keys: Integer.t option
        [@ocaml.doc
          "<p>Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.</p>"];
      common_prefixes: CommonPrefixList.t
        [@ocaml.doc
          "<p>All of the keys rolled up into a common prefix count as a single return when calculating the number of returns.</p> <p>A response can contain <code>CommonPrefixes</code> only if you specify a delimiter.</p> <p> <code>CommonPrefixes</code> contains all (if there are any) keys between <code>Prefix</code> and the next occurrence of the string specified by a delimiter.</p> <p> <code>CommonPrefixes</code> lists keys that act like subdirectories in the directory specified by <code>Prefix</code>.</p> <p>For example, if the prefix is <code>notes/</code> and the delimiter is a slash (<code>/</code>) as in <code>notes/summer/july</code>, the common prefix is <code>notes/summer/</code>. All of the keys that roll up into a common prefix count as a single return when calculating the number of returns. </p>"];
      encoding_type: EncodingType.t option
        [@ocaml.doc
          "<p>Encoding type used by Amazon S3 to encode object key names in the XML response.</p> <p>If you specify the encoding-type request parameter, Amazon S3 includes this element in the response, and returns encoded key name values in the following response elements:</p> <p> <code>Delimiter, Prefix, Key,</code> and <code>StartAfter</code>.</p>"];
      key_count: Integer.t option
        [@ocaml.doc
          "<p>KeyCount is the number of keys returned with this request. KeyCount will always be less than equals to MaxKeys field. Say you ask for 50 keys, your result will include less than equals 50 keys </p>"];
      continuation_token: String.t option
        [@ocaml.doc
          "<p> If ContinuationToken was sent with the request, it is included in the response.</p>"];
      next_continuation_token: String.t option
        [@ocaml.doc
          "<p> <code>NextContinuationToken</code> is sent when <code>isTruncated</code> is true, which means there are more keys in the bucket that can be listed. The next list requests to Amazon S3 can be continued with this <code>NextContinuationToken</code>. <code>NextContinuationToken</code> is obfuscated and is not a real key</p>"];
      start_after: String.t option
        [@ocaml.doc
          "<p>If StartAfter was sent with the request, it is included in the response.</p>"]}
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module PutObjectRetentionOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
  end
module CreateMultipartUploadOutput =
  struct
    type t =
      {
      abort_date: DateTime.t option
        [@ocaml.doc
          "<p>If the bucket has a lifecycle rule configured with an action to abort incomplete multipart uploads and the prefix in the lifecycle rule matches the object name in the request, the response includes this header. The header indicates when the initiated multipart upload becomes eligible for an abort operation. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\"> Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a>.</p> <p>The response also includes the <code>x-amz-abort-rule-id</code> header that provides the ID of the lifecycle configuration rule that defines this action.</p>"];
      abort_rule_id: String.t option
        [@ocaml.doc
          "<p>This header is returned along with the <code>x-amz-abort-date</code> header. It identifies the applicable lifecycle configuration rule that defines the action to abort incomplete multipart uploads.</p>"];
      bucket: String.t option
        [@ocaml.doc
          "<p>Name of the bucket to which the multipart upload was initiated. </p> <p>When using this API with an access point, you must direct requests to the access point hostname. The access point hostname takes the form <i>AccessPointName</i>-<i>AccountId</i>.s3-accesspoint.<i>Region</i>.amazonaws.com. When using this operation using an access point through the AWS SDKs, you provide the access point ARN in place of the bucket name. For more information about access point ARNs, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-access-points.html\">Using Access Points</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p>"];
      key: String.t option
        [@ocaml.doc
          "<p>Object key for which the multipart upload was initiated.</p>"];
      upload_id: String.t option
        [@ocaml.doc "<p>ID for the initiated multipart upload.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>"];
      s_s_e_k_m_s_encryption_context: String.t option
        [@ocaml.doc
          "<p>If present, specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>"];
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
  end
module GetBucketAnalyticsConfigurationOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module GetBucketPolicyStatusOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module RestoreObjectOutput =
  struct
    type t =
      {
      request_charged: RequestCharged.t option ;
      restore_output_path: String.t option
        [@ocaml.doc
          "<p>Indicates the path in the provided S3 output location where Select results will be restored to.</p>"]}
    let make ?request_charged  ?restore_output_path  () =
      { request_charged; restore_output_path }
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.restore_output_path
              (fun f -> ("restore_output_path", (String.to_json f)));
           Util.option_map v.request_charged
             (fun f -> ("request_charged", (RequestCharged.to_json f)))])
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
  end
module GetBucketLifecycleOutput =
  struct
    type t =
      {
      rules: Rules.t [@ocaml.doc "<p>Container for a lifecycle rule.</p>"]}
    let make ?(rules= [])  () = { rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("rules", (Rules.to_json v.rules))])
    let parse xml = Some { rules = (Util.of_option [] (Rules.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Rule" ([], (Rules.to_xml [x]))))
              v.rules))
  end
module DeleteObjectTaggingOutput =
  struct
    type t =
      {
      version_id: String.t option
        [@ocaml.doc
          "<p>The versionId of the object the tag-set was removed from.</p>"]}
    let make ?version_id  () = { version_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f ->
                 Headers.Pair ("x-amz-version-id", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.version_id
              (fun f ->
                 Ezxmlm.make_tag "x-amz-version-id" ([], (String.to_xml f)))])
  end
module GetBucketLocationOutput =
  struct
    type t =
      {
      location_constraint: BucketLocationConstraint.t option
        [@ocaml.doc
          "<p>Specifies the Region where the bucket resides. For a list of all the Amazon S3 supported location constraints by Region, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\">Regions and Endpoints</a>.</p>"]}
    let make ?location_constraint  () = { location_constraint }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.location_constraint
              (fun f ->
                 ("location_constraint",
                   (BucketLocationConstraint.to_json f)))])
    let parse xml =
      Some
        {
          location_constraint =
            (Util.option_bind (Xml.member "LocationConstraint" xml)
               BucketLocationConstraint.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.location_constraint
              (fun f ->
                 Ezxmlm.make_tag "LocationConstraint"
                   ([], (BucketLocationConstraint.to_xml f)))])
  end
module PutObjectTaggingOutput =
  struct
    type t =
      {
      version_id: String.t option
        [@ocaml.doc
          "<p>The versionId of the object the tag-set was added to.</p>"]}
    let make ?version_id  () = { version_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f ->
                 Headers.Pair ("x-amz-version-id", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.version_id
              (fun f ->
                 Ezxmlm.make_tag "x-amz-version-id" ([], (String.to_xml f)))])
  end
module ListBucketAnalyticsConfigurationsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the returned list of analytics configurations is complete. A value of true indicates that the list is not complete and the NextContinuationToken will be provided for a subsequent request.</p>"];
      continuation_token: String.t option
        [@ocaml.doc
          "<p>The marker that is used as a starting point for this analytics configuration list response. This value is present if it was sent in the request.</p>"];
      next_continuation_token: String.t option
        [@ocaml.doc
          "<p> <code>NextContinuationToken</code> is sent when <code>isTruncated</code> is true, which indicates that there are more analytics configurations to list. The next request must include this <code>NextContinuationToken</code>. The token is obfuscated and is not a usable value.</p>"];
      analytics_configuration_list: AnalyticsConfigurationList.t
        [@ocaml.doc
          "<p>The list of analytics configurations for a bucket.</p>"]}
    let make ?is_truncated  ?continuation_token  ?next_continuation_token 
      ?(analytics_configuration_list= [])  () =
      {
        is_truncated;
        continuation_token;
        next_continuation_token;
        analytics_configuration_list
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module GetObjectTaggingOutput =
  struct
    type t =
      {
      version_id: String.t option
        [@ocaml.doc
          "<p>The versionId of the object for which you got the tagging information.</p>"];
      tag_set: TagSet.t [@ocaml.doc "<p>Contains the tag set.</p>"]}
    let make ?version_id  ~tag_set  () = { version_id; tag_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f ->
                 Headers.Pair ("x-amz-version-id", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_set", (TagSet.to_json v.tag_set));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)))])
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
  end
module GetBucketLifecycleConfigurationOutput =
  struct
    type t =
      {
      rules: LifecycleRules.t
        [@ocaml.doc "<p>Container for a lifecycle rule.</p>"]}
    let make ?(rules= [])  () = { rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (LifecycleRules.to_json v.rules))])
    let parse xml =
      Some { rules = (Util.of_option [] (LifecycleRules.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule" ([], (LifecycleRules.to_xml [x]))))
              v.rules))
  end
module GetBucketPolicyOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers = ()
  end
module ListObjectVersionsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p>A flag that indicates whether Amazon S3 returned all of the results that satisfied the search criteria. If your results were truncated, you can make a follow-up paginated request using the NextKeyMarker and NextVersionIdMarker response parameters as a starting place in another request to return the rest of the results.</p>"];
      key_marker: String.t option
        [@ocaml.doc
          "<p>Marks the last key returned in a truncated response.</p>"];
      version_id_marker: String.t option
        [@ocaml.doc
          "<p>Marks the last version of the key returned in a truncated response.</p>"];
      next_key_marker: String.t option
        [@ocaml.doc
          "<p>When the number of responses exceeds the value of <code>MaxKeys</code>, <code>NextKeyMarker</code> specifies the first key not returned that satisfies the search criteria. Use this value for the key-marker request parameter in a subsequent request.</p>"];
      next_version_id_marker: String.t option
        [@ocaml.doc
          "<p>When the number of responses exceeds the value of <code>MaxKeys</code>, <code>NextVersionIdMarker</code> specifies the first object version not returned that satisfies the search criteria. Use this value for the version-id-marker request parameter in a subsequent request.</p>"];
      versions: ObjectVersionList.t
        [@ocaml.doc "<p>Container for version information.</p>"];
      delete_markers: DeleteMarkers.t
        [@ocaml.doc
          "<p>Container for an object that is a delete marker.</p>"];
      name: String.t option [@ocaml.doc "<p>Bucket name.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>Selects objects that start with the value supplied by this parameter.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>The delimiter grouping the included keys. A delimiter is a character that you specify to group keys. All keys that contain the same string between the prefix and the first occurrence of the delimiter are grouped under a single result element in <code>CommonPrefixes</code>. These groups are counted as one result against the max-keys limitation. These keys are not returned elsewhere in the response.</p>"];
      max_keys: Integer.t option
        [@ocaml.doc
          "<p>Specifies the maximum number of objects to return.</p>"];
      common_prefixes: CommonPrefixList.t
        [@ocaml.doc
          "<p>All of the keys rolled up into a common prefix count as a single return when calculating the number of returns.</p>"];
      encoding_type: EncodingType.t option
        [@ocaml.doc
          "<p> Encoding type used by Amazon S3 to encode object key names in the XML response.</p> <p>If you specify encoding-type request parameter, Amazon S3 includes this element in the response, and returns encoded key name values in the following response elements:</p> <p> <code>KeyMarker, NextKeyMarker, Prefix, Key</code>, and <code>Delimiter</code>.</p>"]}
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module DeleteObjectOutput =
  struct
    type t =
      {
      delete_marker: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.</p>"];
      version_id: String.t option
        [@ocaml.doc
          "<p>Returns the version ID of the delete marker created as a result of the DELETE operation.</p>"];
      request_charged: RequestCharged.t option }
    let make ?delete_marker  ?version_id  ?request_charged  () =
      { delete_marker; version_id; request_charged }
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.delete_marker
             (fun f -> ("delete_marker", (Boolean.to_json f)))])
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
  end
module CompleteMultipartUploadOutput =
  struct
    type t =
      {
      location: String.t option
        [@ocaml.doc
          "<p>The URI that identifies the newly created object.</p>"];
      bucket: String.t option
        [@ocaml.doc
          "<p>The name of the bucket that contains the newly created object.</p>"];
      key: String.t option
        [@ocaml.doc "<p>The object key of the newly created object.</p>"];
      expiration: String.t option
        [@ocaml.doc
          "<p>If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.</p>"];
      e_tag: String.t option
        [@ocaml.doc
          "<p>Entity tag that identifies the newly created object's data. Objects with different object data will have different entity tags. The entity tag is an opaque string. The entity tag may or may not be an MD5 digest of the object data. If the entity tag is not an MD5 digest of the object data, it will contain one or more nonhexadecimal characters and/or will consist of less than 32 or more than 32 hexadecimal digits.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>If you specified server-side encryption either with an Amazon S3-managed encryption key or an AWS KMS customer master key (CMK) in your initiate multipart upload request, the response includes this header. It confirms the encryption algorithm that Amazon S3 used to encrypt the object.</p>"];
      version_id: String.t option
        [@ocaml.doc
          "<p>Version ID of the newly created object, in case the bucket has versioning turned on.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>"];
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
  end
module GetBucketAclOutput =
  struct
    type t =
      {
      owner: Owner.t option
        [@ocaml.doc
          "<p>Container for the bucket owner's display name and ID.</p>"];
      grants: Grants.t [@ocaml.doc "<p>A list of grants.</p>"]}
    let make ?owner  ?(grants= [])  () = { owner; grants }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("grants", (Grants.to_json v.grants));
           Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)))])
    let parse xml =
      Some
        {
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse);
          grants =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccessControlList" xml)
                  Grants.parse))
        }
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
  end
module GetObjectAclOutput =
  struct
    type t =
      {
      owner: Owner.t option
        [@ocaml.doc
          "<p> Container for the bucket owner's display name and ID.</p>"];
      grants: Grants.t [@ocaml.doc "<p>A list of grants.</p>"];
      request_charged: RequestCharged.t option }
    let make ?owner  ?(grants= [])  ?request_charged  () =
      { owner; grants; request_charged }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Some ("grants", (Grants.to_json v.grants));
           Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)))])
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
  end
module UploadPartOutput =
  struct
    type t =
      {
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>"];
      e_tag: String.t option
        [@ocaml.doc "<p>Entity tag for the uploaded object.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) was used for the object.</p>"];
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
  end
module ListBucketInventoryConfigurationsOutput =
  struct
    type t =
      {
      continuation_token: String.t option
        [@ocaml.doc
          "<p>If sent in the request, the marker that is used as a starting point for this inventory configuration list response.</p>"];
      inventory_configuration_list: InventoryConfigurationList.t
        [@ocaml.doc
          "<p>The list of inventory configurations for a bucket.</p>"];
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p>Tells whether the returned list of inventory configurations is complete. A value of true indicates that the list is not complete and the NextContinuationToken is provided for a subsequent request.</p>"];
      next_continuation_token: String.t option
        [@ocaml.doc
          "<p>The marker used to continue this inventory configuration listing. Use the <code>NextContinuationToken</code> from this response to continue the listing in a subsequent request. The continuation token is an opaque value that Amazon S3 understands.</p>"]}
    let make ?continuation_token  ?(inventory_configuration_list= []) 
      ?is_truncated  ?next_continuation_token  () =
      {
        continuation_token;
        inventory_configuration_list;
        is_truncated;
        next_continuation_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module PutObjectLockConfigurationOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
  end
module GetBucketLoggingOutput =
  struct
    type t = {
      logging_enabled: LoggingEnabled.t option }
    let make ?logging_enabled  () = { logging_enabled }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.logging_enabled
              (fun f -> ("logging_enabled", (LoggingEnabled.to_json f)))])
    let parse xml =
      Some
        {
          logging_enabled =
            (Util.option_bind (Xml.member "LoggingEnabled" xml)
               LoggingEnabled.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.logging_enabled
              (fun f ->
                 Ezxmlm.make_tag "LoggingEnabled"
                   ([], (LoggingEnabled.to_xml f)))])
  end
module GetBucketVersioningOutput =
  struct
    type t =
      {
      status: BucketVersioningStatus.t option
        [@ocaml.doc "<p>The versioning state of the bucket.</p>"];
      m_f_a_delete: MFADeleteStatus.t option
        [@ocaml.doc
          "<p>Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.</p>"]}
    let make ?status  ?m_f_a_delete  () = { status; m_f_a_delete }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.m_f_a_delete
              (fun f -> ("m_f_a_delete", (MFADeleteStatus.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (BucketVersioningStatus.to_json f)))])
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
  end
module GetObjectLockConfigurationOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module GetPublicAccessBlockOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module CreateBucketOutput =
  struct
    type t =
      {
      location: String.t option
        [@ocaml.doc
          "<p>Specifies the Region where the bucket will be created. If you are creating a bucket on the US East (N. Virginia) Region (us-east-1), you do not need to specify the location.</p>"]}
    let make ?location  () = { location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.location
              (fun f -> Headers.Pair ("Location", (String.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.location
              (fun f -> ("location", (String.to_json f)))])
    let parse xml =
      Some
        {
          location =
            (Util.option_bind (Xml.member "Location" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.location
              (fun f -> Ezxmlm.make_tag "Location" ([], (String.to_xml f)))])
  end
module GetBucketRequestPaymentOutput =
  struct
    type t =
      {
      payer: Payer.t option
        [@ocaml.doc
          "<p>Specifies who pays for the download and request fees.</p>"]}
    let make ?payer  () = { payer }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.payer (fun f -> ("payer", (Payer.to_json f)))])
    let parse xml =
      Some
        { payer = (Util.option_bind (Xml.member "Payer" xml) Payer.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.payer
              (fun f -> Ezxmlm.make_tag "Payer" ([], (Payer.to_xml f)))])
  end
module PutObjectLegalHoldOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
  end
module GetBucketReplicationOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module AbortMultipartUploadOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
  end
module GetBucketWebsiteOutput =
  struct
    type t =
      {
      redirect_all_requests_to: RedirectAllRequestsTo.t option
        [@ocaml.doc
          "<p>Specifies the redirect behavior of all requests to a website endpoint of an Amazon S3 bucket.</p>"];
      index_document: IndexDocument.t option
        [@ocaml.doc "<p>The name of the index document for the website.</p>"];
      error_document: ErrorDocument.t option
        [@ocaml.doc "<p>The name of the error document for the website.</p>"];
      routing_rules: RoutingRules.t
        [@ocaml.doc
          "<p>Rules that define when a redirect is applied and the redirect behavior.</p>"]}
    let make ?redirect_all_requests_to  ?index_document  ?error_document 
      ?(routing_rules= [])  () =
      {
        redirect_all_requests_to;
        index_document;
        error_document;
        routing_rules
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module ListObjectsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p>A flag that indicates whether Amazon S3 returned all of the results that satisfied the search criteria.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>Indicates where in the bucket listing begins. Marker is included in the response if it was sent with the request.</p>"];
      next_marker: String.t option
        [@ocaml.doc
          "<p>When response is truncated (the IsTruncated element value in the response is true), you can use the key name in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in alphabetical order Note: This element is returned only if you have delimiter request parameter specified. If response does not include the NextMaker and it is truncated, you can use the value of the last Key in the response as the marker in the subsequent request to get the next set of object keys.</p>"];
      contents: ObjectList.t
        [@ocaml.doc "<p>Metadata about each object returned.</p>"];
      name: String.t option [@ocaml.doc "<p>Bucket name.</p>"];
      prefix: String.t option
        [@ocaml.doc "<p>Keys that begin with the indicated prefix.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>Causes keys that contain the same string between the prefix and the first occurrence of the delimiter to be rolled up into a single result element in the <code>CommonPrefixes</code> collection. These rolled-up keys are not returned elsewhere in the response. Each rolled-up result counts as only one return against the <code>MaxKeys</code> value.</p>"];
      max_keys: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of keys returned in the response body.</p>"];
      common_prefixes: CommonPrefixList.t
        [@ocaml.doc
          "<p>All of the keys rolled up in a common prefix count as a single return when calculating the number of returns. </p> <p>A response can contain CommonPrefixes only if you specify a delimiter.</p> <p>CommonPrefixes contains all (if there are any) keys between Prefix and the next occurrence of the string specified by the delimiter.</p> <p> CommonPrefixes lists keys that act like subdirectories in the directory specified by Prefix.</p> <p>For example, if the prefix is notes/ and the delimiter is a slash (/) as in notes/summer/july, the common prefix is notes/summer/. All of the keys that roll up into a common prefix count as a single return when calculating the number of returns.</p>"];
      encoding_type: EncodingType.t option
        [@ocaml.doc
          "<p>Encoding type used by Amazon S3 to encode object keys in the response.</p>"]}
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module GetBucketEncryptionOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module HeadObjectOutput =
  struct
    type t =
      {
      delete_marker: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.</p>"];
      accept_ranges: String.t option
        [@ocaml.doc "<p>Indicates that a range of bytes was specified.</p>"];
      expiration: String.t option
        [@ocaml.doc
          "<p>If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key-value pairs providing object expiration information. The value of the rule-id is URL encoded.</p>"];
      restore: String.t option
        [@ocaml.doc
          "<p>If the object is an archived object (an object whose storage class is GLACIER), the response includes this header if either the archive restoration is in progress (see <a>RestoreObject</a> or an archive copy is already restored.</p> <p> If an archive copy is already restored, the header value indicates when Amazon S3 is scheduled to delete the object copy. For example:</p> <p> <code>x-amz-restore: ongoing-request=\"false\", expiry-date=\"Fri, 23 Dec 2012 00:00:00 GMT\"</code> </p> <p>If the object restoration is in progress, the header returns the value <code>ongoing-request=\"true\"</code>.</p> <p>For more information about archiving objects, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html#lifecycle-transition-general-considerations\">Transitioning Objects: General Considerations</a>.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc "<p>Last modified date of the object</p>"];
      content_length: Long.t option
        [@ocaml.doc "<p>Size of the body in bytes.</p>"];
      e_tag: String.t option
        [@ocaml.doc
          "<p>An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL.</p>"];
      missing_meta: Integer.t option
        [@ocaml.doc
          "<p>This is set to the number of metadata entries not returned in <code>x-amz-meta</code> headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>Version of the object.</p>"];
      cache_control: String.t option
        [@ocaml.doc
          "<p>Specifies caching behavior along the request/reply chain.</p>"];
      content_disposition: String.t option
        [@ocaml.doc
          "<p>Specifies presentational information for the object.</p>"];
      content_encoding: String.t option
        [@ocaml.doc
          "<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.</p>"];
      content_language: String.t option
        [@ocaml.doc "<p>The language the content is in.</p>"];
      content_type: String.t option
        [@ocaml.doc
          "<p>A standard MIME type describing the format of the object data.</p>"];
      expires: DateTime.t option
        [@ocaml.doc
          "<p>The date and time at which the object is no longer cacheable.</p>"];
      website_redirect_location: String.t option
        [@ocaml.doc
          "<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>If the object is stored using server-side encryption either with an AWS KMS customer master key (CMK) or an Amazon S3-managed encryption key, the response includes this header with the value of the server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>"];
      metadata: Metadata.t option
        [@ocaml.doc
          "<p>A map of metadata to store with the object in S3.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>"];
      storage_class: StorageClass.t option
        [@ocaml.doc
          "<p>Provides storage class information of the object. Amazon S3 returns this header for all objects except for Standard storage class objects.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html\">Storage Classes</a>.</p>"];
      request_charged: RequestCharged.t option ;
      replication_status: ReplicationStatus.t option
        [@ocaml.doc
          "<p>Amazon S3 can return this header if your request involves a bucket that is either a source or destination in a replication rule.</p> <p>In replication, you have a source bucket on which you configure replication and destination bucket where Amazon S3 stores object replicas. When you request an object (<code>GetObject</code>) or object metadata (<code>HeadObject</code>) from these buckets, Amazon S3 will return the <code>x-amz-replication-status</code> header in the response as follows:</p> <ul> <li> <p>If requesting an object from the source bucket \226\128\148 Amazon S3 will return the <code>x-amz-replication-status</code> header if the object in your request is eligible for replication.</p> <p> For example, suppose that in your replication configuration, you specify object prefix <code>TaxDocs</code> requesting Amazon S3 to replicate objects with key prefix <code>TaxDocs</code>. Any objects you upload with this key name prefix, for example <code>TaxDocs/document1.pdf</code>, are eligible for replication. For any object request with this key name prefix, Amazon S3 will return the <code>x-amz-replication-status</code> header with value PENDING, COMPLETED or FAILED indicating object replication status.</p> </li> <li> <p>If requesting an object from the destination bucket \226\128\148 Amazon S3 will return the <code>x-amz-replication-status</code> header with value REPLICA if the object in your request is a replica that Amazon S3 created.</p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Replication</a>.</p>"];
      parts_count: Integer.t option
        [@ocaml.doc "<p>The count of parts this object has.</p>"];
      object_lock_mode: ObjectLockMode.t option
        [@ocaml.doc
          "<p>The Object Lock mode, if any, that's in effect for this object. This header is only returned if the requester has the <code>s3:GetObjectRetention</code> permission. For more information about S3 Object Lock, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\">Object Lock</a>. </p>"];
      object_lock_retain_until_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the Object Lock retention period expires. This header is only returned if the requester has the <code>s3:GetObjectRetention</code> permission.</p>"];
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option
        [@ocaml.doc
          "<p>Specifies whether a legal hold is in effect for this object. This header is only returned if the requester has the <code>s3:GetObjectLegalHold</code> permission. This header is not returned if the specified version of this object has never had a legal hold applied. For more information about S3 Object Lock, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\">Object Lock</a>.</p>"]}
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
  end
module PutObjectAclOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
  end
module ListBucketMetricsConfigurationsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the returned list of metrics configurations is complete. A value of true indicates that the list is not complete and the NextContinuationToken will be provided for a subsequent request.</p>"];
      continuation_token: String.t option
        [@ocaml.doc
          "<p>The marker that is used as a starting point for this metrics configuration list response. This value is present if it was sent in the request.</p>"];
      next_continuation_token: String.t option
        [@ocaml.doc
          "<p>The marker used to continue a metrics configuration listing that has been truncated. Use the <code>NextContinuationToken</code> from a previously truncated list response to continue the listing. The continuation token is an opaque value that Amazon S3 understands.</p>"];
      metrics_configuration_list: MetricsConfigurationList.t
        [@ocaml.doc
          "<p>The list of metrics configurations for a bucket.</p>"]}
    let make ?is_truncated  ?continuation_token  ?next_continuation_token 
      ?(metrics_configuration_list= [])  () =
      {
        is_truncated;
        continuation_token;
        next_continuation_token;
        metrics_configuration_list
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module GetObjectRetentionOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module GetObjectTorrentOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let of_headers headers =
      {
        request_charged =
          (Util.option_map
             (Headers.Assoc.find "x-amz-request-charged" headers)
             RequestCharged.of_string)
      }
  end
module GetBucketCorsOutput =
  struct
    type t =
      {
      c_o_r_s_rules: CORSRules.t
        [@ocaml.doc
          "<p>A set of origins and methods (cross-origin access that you want to allow). You can add up to 100 rules to the configuration.</p>"]}
    let make ?(c_o_r_s_rules= [])  () = { c_o_r_s_rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("c_o_r_s_rules", (CORSRules.to_json v.c_o_r_s_rules))])
    let parse xml =
      Some { c_o_r_s_rules = (Util.of_option [] (CORSRules.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CORSRule" ([], (CORSRules.to_xml [x]))))
              v.c_o_r_s_rules))
  end
module ListBucketsOutput =
  struct
    type t =
      {
      buckets: Buckets.t
        [@ocaml.doc "<p>The list of buckets owned by the requestor.</p>"];
      owner: Owner.t option
        [@ocaml.doc "<p>The owner of the buckets listed.</p>"]}
    let make ?(buckets= [])  ?owner  () = { buckets; owner }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Some ("buckets", (Buckets.to_json v.buckets))])
    let parse xml =
      Some
        {
          buckets =
            (Util.of_option []
               (Util.option_bind (Xml.member "Buckets" xml) Buckets.parse));
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse)
        }
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
  end
module GetBucketAccelerateConfigurationOutput =
  struct
    type t =
      {
      status: BucketAccelerateStatus.t option
        [@ocaml.doc "<p>The accelerate configuration of the bucket.</p>"]}
    let make ?status  () = { status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (BucketAccelerateStatus.to_json f)))])
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               BucketAccelerateStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (BucketAccelerateStatus.to_xml f)))])
  end
module PutObjectOutput =
  struct
    type t =
      {
      expiration: String.t option
        [@ocaml.doc
          "<p> If the expiration is configured for the object (see <a>PutBucketLifecycleConfiguration</a>), the response includes this header. It includes the expiry-date and rule-id key-value pairs that provide information about object expiration. The value of the rule-id is URL encoded.</p>"];
      e_tag: String.t option
        [@ocaml.doc "<p>Entity tag for the uploaded object.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>If you specified server-side encryption either with an AWS KMS customer master key (CMK) or Amazon S3-managed encryption key in your PUT request, the response includes this header. It confirms the encryption algorithm that Amazon S3 used to encrypt the object.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>Version of the object.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If <code>x-amz-server-side-encryption</code> is present and has the value of <code>aws:kms</code>, this header specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object. </p>"];
      s_s_e_k_m_s_encryption_context: String.t option
        [@ocaml.doc
          "<p>If present, specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>"];
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
  end
module GetBucketTaggingOutput =
  struct
    type t = {
      tag_set: TagSet.t [@ocaml.doc "<p>Contains the tag set.</p>"]}
    let make ~tag_set  () = { tag_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("tag_set", (TagSet.to_json v.tag_set))])
    let parse xml =
      Some
        {
          tag_set =
            (Xml.required "TagSet"
               (Util.option_bind (Xml.member "TagSet" xml) TagSet.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagSet" ([], (TagSet.to_xml [x]))))
              v.tag_set))
  end
module SelectObjectContentOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module GetObjectLegalHoldOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module DeleteObjectsOutput =
  struct
    type t =
      {
      deleted: DeletedObjects.t
        [@ocaml.doc
          "<p>Container element for a successful delete. It identifies the object that was successfully deleted.</p>"];
      request_charged: RequestCharged.t option ;
      errors: Errors.t
        [@ocaml.doc
          "<p>Container for a failed delete operation that describes the object that Amazon S3 attempted to delete and the error it encountered.</p>"]}
    let make ?(deleted= [])  ?request_charged  ?(errors= [])  () =
      { deleted; request_charged; errors }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("errors", (Errors.to_json v.errors));
           Util.option_map v.request_charged
             (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Some ("deleted", (DeletedObjects.to_json v.deleted))])
    let parse xml =
      Some
        {
          deleted = (Util.of_option [] (DeletedObjects.parse xml));
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse);
          errors = (Util.of_option [] (Errors.parse xml))
        }
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
  end
module UploadPartCopyOutput =
  struct
    type t =
      {
      copy_source_version_id: String.t option
        [@ocaml.doc
          "<p>The version of the source object that was copied, if you have enabled versioning on the source bucket.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>"];
      request_charged: RequestCharged.t option }
    let make ?copy_source_version_id  ?server_side_encryption 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key_m_d5 
      ?s_s_e_k_m_s_key_id  ?request_charged  () =
      {
        copy_source_version_id;
        server_side_encryption;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        request_charged
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
           Util.option_map v.copy_source_version_id
             (fun f -> ("copy_source_version_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          copy_source_version_id =
            (Util.option_bind (Xml.member "x-amz-copy-source-version-id" xml)
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
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.copy_source_version_id
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-copy-source-version-id"
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
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let of_headers headers body =
      {
        copy_source_version_id =
          (Util.option_map
             (Headers.Assoc.find "x-amz-copy-source-version-id" headers)
             String.of_string);
        server_side_encryption =
          (Util.option_map
             (Headers.Assoc.find "x-amz-server-side-encryption" headers)
             ServerSideEncryption.of_string);
        s_s_e_customer_algorithm =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-customer-algorithm" headers)
             String.of_string);
        s_s_e_customer_key_m_d5 =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-customer-key-MD5" headers)
             String.of_string);
        s_s_e_k_m_s_key_id =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-aws-kms-key-id" headers)
             String.of_string);
        request_charged =
          (Util.option_map
             (Headers.Assoc.find "x-amz-request-charged" headers)
             RequestCharged.of_string)
      }
  end
module GetBucketMetricsConfigurationOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module ListPartsOutput =
  struct
    type t =
      {
      abort_date: DateTime.t option
        [@ocaml.doc
          "<p>If the bucket has a lifecycle rule configured with an action to abort incomplete multipart uploads and the prefix in the lifecycle rule matches the object name in the request, then the response includes this header indicating when the initiated multipart upload will become eligible for abort operation. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config\">Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy</a>.</p> <p>The response will also include the <code>x-amz-abort-rule-id</code> header that will provide the ID of the lifecycle configuration rule that defines this action.</p>"];
      abort_rule_id: String.t option
        [@ocaml.doc
          "<p>This header is returned along with the <code>x-amz-abort-date</code> header. It identifies applicable lifecycle configuration rule that defines the action to abort incomplete multipart uploads.</p>"];
      bucket: String.t option
        [@ocaml.doc
          "<p>Name of the bucket to which the multipart upload was initiated.</p>"];
      key: String.t option
        [@ocaml.doc
          "<p>Object key for which the multipart upload was initiated.</p>"];
      upload_id: String.t option
        [@ocaml.doc
          "<p>Upload ID identifying the multipart upload whose parts are being listed.</p>"];
      part_number_marker: Integer.t option
        [@ocaml.doc
          "<p>When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.</p>"];
      next_part_number_marker: Integer.t option
        [@ocaml.doc
          "<p>When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.</p>"];
      max_parts: Integer.t option
        [@ocaml.doc
          "<p>Maximum number of parts that were allowed in the response.</p>"];
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p> Indicates whether the returned list of parts is truncated. A true value indicates that the list was truncated. A list can be truncated if the number of parts exceeds the limit returned in the MaxParts element.</p>"];
      parts: Parts.t
        [@ocaml.doc
          "<p> Container for elements related to a particular part. A response can contain zero or more <code>Part</code> elements.</p>"];
      initiator: Initiator.t option
        [@ocaml.doc
          "<p>Container element that identifies who initiated the multipart upload. If the initiator is an AWS account, this element provides the same information as the <code>Owner</code> element. If the initiator is an IAM User, this element provides the user ARN and display name.</p>"];
      owner: Owner.t option
        [@ocaml.doc
          "<p> Container element that identifies the object owner, after the object is created. If multipart upload is initiated by an IAM user, this element provides the parent account ID and display name.</p>"];
      storage_class: StorageClass.t option
        [@ocaml.doc
          "<p>Class of storage (STANDARD or REDUCED_REDUNDANCY) used to store the uploaded object.</p>"];
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
  end
module ListMultipartUploadsOutput =
  struct
    type t =
      {
      bucket: String.t option
        [@ocaml.doc
          "<p>Name of the bucket to which the multipart upload was initiated.</p>"];
      key_marker: String.t option
        [@ocaml.doc "<p>The key at or after which the listing began.</p>"];
      upload_id_marker: String.t option
        [@ocaml.doc "<p>Upload ID after which listing began.</p>"];
      next_key_marker: String.t option
        [@ocaml.doc
          "<p>When a list is truncated, this element specifies the value that should be used for the key-marker request parameter in a subsequent request.</p>"];
      prefix: String.t option
        [@ocaml.doc
          "<p>When a prefix is provided in the request, this field contains the specified prefix. The result contains only keys starting with the specified prefix.</p>"];
      delimiter: String.t option
        [@ocaml.doc
          "<p>Contains the delimiter you specified in the request. If you don't specify a delimiter in your request, this element is absent from the response.</p>"];
      next_upload_id_marker: String.t option
        [@ocaml.doc
          "<p>When a list is truncated, this element specifies the value that should be used for the <code>upload-id-marker</code> request parameter in a subsequent request.</p>"];
      max_uploads: Integer.t option
        [@ocaml.doc
          "<p>Maximum number of multipart uploads that could have been included in the response.</p>"];
      is_truncated: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the returned list of multipart uploads is truncated. A value of true indicates that the list was truncated. The list can be truncated if the number of multipart uploads exceeds the limit allowed or specified by max uploads.</p>"];
      uploads: MultipartUploadList.t
        [@ocaml.doc
          "<p>Container for elements related to a particular multipart upload. A response can contain zero or more <code>Upload</code> elements.</p>"];
      common_prefixes: CommonPrefixList.t
        [@ocaml.doc
          "<p>If you specify a delimiter in the request, then the result returns each distinct key prefix containing the delimiter in a <code>CommonPrefixes</code> element. The distinct key prefixes are returned in the <code>Prefix</code> child element.</p>"];
      encoding_type: EncodingType.t option
        [@ocaml.doc
          "<p>Encoding type used by Amazon S3 to encode object keys in the response.</p> <p>If you specify <code>encoding-type</code> request parameter, Amazon S3 includes this element in the response, and returns encoded key name values in the following response elements:</p> <p> <code>Delimiter</code>, <code>KeyMarker</code>, <code>Prefix</code>, <code>NextKeyMarker</code>, <code>Key</code>.</p>"]}
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module CopyObjectOutput =
  struct
    type t =
      {
      expiration: String.t option
        [@ocaml.doc
          "<p>If the object expiration is configured, the response includes this header.</p>"];
      copy_source_version_id: String.t option
        [@ocaml.doc
          "<p>Version of the copied object in the destination bucket.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>Version ID of the newly created copy.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>"];
      s_s_e_k_m_s_encryption_context: String.t option
        [@ocaml.doc
          "<p>If present, specifies the AWS KMS Encryption Context to use for object encryption. The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.</p>"];
      request_charged: RequestCharged.t option }
    let make ?expiration  ?copy_source_version_id  ?version_id 
      ?server_side_encryption  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id 
      ?s_s_e_k_m_s_encryption_context  ?request_charged  () =
      {
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
             (fun f -> ("expiration", (String.to_json f)))])
    let parse xml =
      Some
        {
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
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
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
    let of_headers headers body =
      {
        expiration =
          (Util.option_map (Headers.Assoc.find "x-amz-expiration" headers)
             String.of_string);
        copy_source_version_id =
          (Util.option_map
             (Headers.Assoc.find "x-amz-copy-source-version-id" headers)
             String.of_string);
        version_id =
          (Util.option_map (Headers.Assoc.find "x-amz-version-id" headers)
             String.of_string);
        server_side_encryption =
          (Util.option_map
             (Headers.Assoc.find "x-amz-server-side-encryption" headers)
             ServerSideEncryption.of_string);
        s_s_e_customer_algorithm =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-customer-algorithm" headers)
             String.of_string);
        s_s_e_customer_key_m_d5 =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-customer-key-MD5" headers)
             String.of_string);
        s_s_e_k_m_s_key_id =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-aws-kms-key-id" headers)
             String.of_string);
        s_s_e_k_m_s_encryption_context =
          (Util.option_map
             (Headers.Assoc.find "x-amz-server-side-encryption-context"
                headers) String.of_string);
        request_charged =
          (Util.option_map
             (Headers.Assoc.find "x-amz-request-charged" headers)
             RequestCharged.of_string)
      }
  end
module GetBucketInventoryConfigurationOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
    let of_headers headers body = ()
  end
module GetObjectOutput =
  struct
    type t =
      {
      delete_marker: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.</p>"];
      accept_ranges: String.t option
        [@ocaml.doc "<p>Indicates that a range of bytes was specified.</p>"];
      expiration: String.t option
        [@ocaml.doc
          "<p>If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key-value pairs providing object expiration information. The value of the rule-id is URL encoded.</p>"];
      restore: String.t option
        [@ocaml.doc
          "<p>Provides information about object restoration operation and expiration time of the restored object copy.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc "<p>Last modified date of the object</p>"];
      content_length: Long.t option
        [@ocaml.doc "<p>Size of the body in bytes.</p>"];
      e_tag: String.t option
        [@ocaml.doc
          "<p>An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL.</p>"];
      missing_meta: Integer.t option
        [@ocaml.doc
          "<p>This is set to the number of metadata entries not returned in <code>x-amz-meta</code> headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.</p>"];
      version_id: String.t option
        [@ocaml.doc "<p>Version of the object.</p>"];
      cache_control: String.t option
        [@ocaml.doc
          "<p>Specifies caching behavior along the request/reply chain.</p>"];
      content_disposition: String.t option
        [@ocaml.doc
          "<p>Specifies presentational information for the object.</p>"];
      content_encoding: String.t option
        [@ocaml.doc
          "<p>Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.</p>"];
      content_language: String.t option
        [@ocaml.doc "<p>The language the content is in.</p>"];
      content_range: String.t option
        [@ocaml.doc
          "<p>The portion of the object returned in the response.</p>"];
      content_type: String.t option
        [@ocaml.doc
          "<p>A standard MIME type describing the format of the object data.</p>"];
      expires: DateTime.t option
        [@ocaml.doc
          "<p>The date and time at which the object is no longer cacheable.</p>"];
      website_redirect_location: String.t option
        [@ocaml.doc
          "<p>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</p>"];
      server_side_encryption: ServerSideEncryption.t option
        [@ocaml.doc
          "<p>The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).</p>"];
      metadata: Metadata.t option
        [@ocaml.doc
          "<p>A map of metadata to store with the object in S3.</p>"];
      s_s_e_customer_algorithm: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.</p>"];
      s_s_e_customer_key_m_d5: String.t option
        [@ocaml.doc
          "<p>If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round-trip message integrity verification of the customer-provided encryption key.</p>"];
      s_s_e_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.</p>"];
      storage_class: StorageClass.t option
        [@ocaml.doc
          "<p>Provides storage class information of the object. Amazon S3 returns this header for all objects except for Standard storage class objects.</p>"];
      request_charged: RequestCharged.t option ;
      replication_status: ReplicationStatus.t option
        [@ocaml.doc
          "<p>Amazon S3 can return this if your request involves a bucket that is either a source or destination in a replication rule.</p>"];
      parts_count: Integer.t option
        [@ocaml.doc "<p>The count of parts this object has.</p>"];
      tag_count: Integer.t option
        [@ocaml.doc "<p>The number of tags, if any, on the object.</p>"];
      object_lock_mode: ObjectLockMode.t option
        [@ocaml.doc
          "<p>The Object Lock mode currently in place for this object.</p>"];
      object_lock_retain_until_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when this object's Object Lock will expire.</p>"];
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option
        [@ocaml.doc
          "<p>Indicates whether this object has an active legal hold. This field is only returned if you have permission to view an object's legal hold status. </p>"]}
    let make ?delete_marker  ?accept_ranges  ?expiration  ?restore 
      ?last_modified  ?content_length  ?e_tag  ?missing_meta  ?version_id 
      ?cache_control  ?content_disposition  ?content_encoding 
      ?content_language  ?content_range  ?content_type  ?expires 
      ?website_redirect_location  ?server_side_encryption  ?metadata 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key_m_d5 
      ?s_s_e_k_m_s_key_id  ?storage_class  ?request_charged 
      ?replication_status  ?parts_count  ?tag_count  ?object_lock_mode 
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
             (fun f -> ("delete_marker", (Boolean.to_json f)))])
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
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((([] @
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
    let of_headers headers =
      {
        delete_marker =
          (Util.option_map (Headers.Assoc.find "x-amz-delete-marker" headers)
             Boolean.of_string);
        accept_ranges =
          (Util.option_map (Headers.Assoc.find "accept-ranges" headers)
             String.of_string);
        expiration =
          (Util.option_map (Headers.Assoc.find "x-amz-expiration" headers)
             String.of_string);
        restore =
          (Util.option_map (Headers.Assoc.find "x-amz-restore" headers)
             String.of_string);
        last_modified =
          (Util.option_map (Headers.Assoc.find "Last-Modified" headers)
             DateTime.of_http_string);
        content_length =
          (Util.option_map (Headers.Assoc.find "Content-Length" headers)
             Long.of_string);
        e_tag =
          (Util.option_map (Headers.Assoc.find "ETag" headers)
             String.of_string);
        missing_meta =
          (Util.option_map (Headers.Assoc.find "x-amz-missing-meta" headers)
             Integer.of_string);
        version_id =
          (Util.option_map (Headers.Assoc.find "x-amz-version-id" headers)
             String.of_string);
        cache_control =
          (Util.option_map (Headers.Assoc.find "Cache-Control" headers)
             String.of_string);
        content_disposition =
          (Util.option_map (Headers.Assoc.find "Content-Disposition" headers)
             String.of_string);
        content_encoding =
          (Util.option_map (Headers.Assoc.find "Content-Encoding" headers)
             String.of_string);
        content_language =
          (Util.option_map (Headers.Assoc.find "Content-Language" headers)
             String.of_string);
        content_range =
          (Util.option_map (Headers.Assoc.find "Content-Range" headers)
             String.of_string);
        content_type =
          (Util.option_map (Headers.Assoc.find "Content-Type" headers)
             String.of_string);
        expires =
          (Util.option_map (Headers.Assoc.find "Expires" headers)
             DateTime.of_http_string);
        website_redirect_location =
          (Util.option_map
             (Headers.Assoc.find "x-amz-website-redirect-location" headers)
             String.of_string);
        server_side_encryption =
          (Util.option_map
             (Headers.Assoc.find "x-amz-server-side-encryption" headers)
             ServerSideEncryption.of_string);
        metadata = (Some (Hashtbl.create 0));
        s_s_e_customer_algorithm =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-customer-algorithm" headers)
             String.of_string);
        s_s_e_customer_key_m_d5 =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-customer-key-MD5" headers)
             String.of_string);
        s_s_e_k_m_s_key_id =
          (Util.option_map
             (Headers.Assoc.find
                "x-amz-server-side-encryption-aws-kms-key-id" headers)
             String.of_string);
        storage_class =
          (Util.option_map (Headers.Assoc.find "x-amz-storage-class" headers)
             StorageClass.of_string);
        request_charged =
          (Util.option_map
             (Headers.Assoc.find "x-amz-request-charged" headers)
             RequestCharged.of_string);
        replication_status =
          (Util.option_map
             (Headers.Assoc.find "x-amz-replication-status" headers)
             ReplicationStatus.of_string);
        parts_count =
          (Util.option_map
             (Headers.Assoc.find "x-amz-mp-parts-count" headers)
             Integer.of_string);
        tag_count =
          (Util.option_map (Headers.Assoc.find "x-amz-tagging-count" headers)
             Integer.of_string);
        object_lock_mode =
          (Util.option_map
             (Headers.Assoc.find "x-amz-object-lock-mode" headers)
             ObjectLockMode.of_string);
        object_lock_retain_until_date =
          (Util.option_map
             (Headers.Assoc.find "x-amz-object-lock-retain-until-date"
                headers) DateTime.of_http_string);
        object_lock_legal_hold_status =
          (Util.option_map
             (Headers.Assoc.find "x-amz-object-lock-legal-hold" headers)
             ObjectLockLegalHoldStatus.of_string)
      }
  end