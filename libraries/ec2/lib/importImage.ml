open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ImportImageRequest =
  struct
    type t =
      {
      architecture: String.t option
        [@ocaml.doc
          "<p>The architecture of the virtual machine.</p> <p>Valid values: <code>i386</code> | <code>x86_64</code> | <code>arm64</code> </p>"];
      client_data: ClientData.t option
        [@ocaml.doc "<p>The client-specific data.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>The token to enable idempotency for VM import requests.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description string for the import image task.</p>"];
      disk_containers: ImageDiskContainerList.t
        [@ocaml.doc "<p>Information about the disk containers.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      encrypted: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the destination AMI of the imported image should be encrypted. The default CMK for EBS is used unless you specify a non-default AWS Key Management Service (AWS KMS) CMK using <code>KmsKeyId</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html\">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      hypervisor: String.t option
        [@ocaml.doc
          "<p>The target hypervisor platform.</p> <p>Valid values: <code>xen</code> </p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>An identifier for the symmetric AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted AMI. This parameter is only required if you want to use a non-default CMK; if this parameter is not specified, the default CMK for EBS is used. If a <code>KmsKeyId</code> is specified, the <code>Encrypted</code> flag must also be set. </p> <p>The CMK identifier may be provided in any of the following formats: </p> <ul> <li> <p>Key ID</p> </li> <li> <p>Key alias. The alias ARN contains the <code>arn:aws:kms</code> namespace, followed by the Region of the CMK, the AWS account ID of the CMK owner, the <code>alias</code> namespace, and then the CMK alias. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:alias/<i>ExampleAlias</i>.</p> </li> <li> <p>ARN using key ID. The ID ARN contains the <code>arn:aws:kms</code> namespace, followed by the Region of the CMK, the AWS account ID of the CMK owner, the <code>key</code> namespace, and then the CMK ID. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:key/<i>abcd1234-a123-456a-a12b-a123b4cd56ef</i>.</p> </li> <li> <p>ARN using key alias. The alias ARN contains the <code>arn:aws:kms</code> namespace, followed by the Region of the CMK, the AWS account ID of the CMK owner, the <code>alias</code> namespace, and then the CMK alias. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:alias/<i>ExampleAlias</i>. </p> </li> </ul> <p>AWS parses <code>KmsKeyId</code> asynchronously, meaning that the action you call may appear to complete even though you provided an invalid identifier. This action will eventually report failure. </p> <p>The specified CMK must exist in the Region that the AMI is being copied to.</p> <p>Amazon EBS does not support asymmetric CMKs.</p>"];
      license_type: String.t option
        [@ocaml.doc
          "<p>The license type to be used for the Amazon Machine Image (AMI) after importing.</p> <p>By default, we detect the source-system operating system (OS) and apply the appropriate license. Specify <code>AWS</code> to replace the source-system license with an AWS license, if appropriate. Specify <code>BYOL</code> to retain the source-system license, if appropriate.</p> <p>To use <code>BYOL</code>, you must have existing licenses with rights to use these licenses in a third party cloud, such as AWS. For more information, see <a href=\"https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html#prerequisites-image\">Prerequisites</a> in the VM Import/Export User Guide.</p>"];
      platform: String.t option
        [@ocaml.doc
          "<p>The operating system of the virtual machine.</p> <p>Valid values: <code>Windows</code> | <code>Linux</code> </p>"];
      role_name: String.t option
        [@ocaml.doc
          "<p>The name of the role to use when not using the default role, 'vmimport'.</p>"];
      license_specifications: ImportImageLicenseSpecificationListRequest.t
        [@ocaml.doc "<p>The ARNs of the license configurations.</p>"]}
    let make ?architecture  ?client_data  ?client_token  ?description 
      ?(disk_containers= [])  ?dry_run  ?encrypted  ?hypervisor  ?kms_key_id 
      ?license_type  ?platform  ?role_name  ?(license_specifications= [])  ()
      =
      {
        architecture;
        client_data;
        client_token;
        description;
        disk_containers;
        dry_run;
        encrypted;
        hypervisor;
        kms_key_id;
        license_type;
        platform;
        role_name;
        license_specifications
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("LicenseSpecifications",
                   (ImportImageLicenseSpecificationListRequest.to_query
                      v.license_specifications)));
           Util.option_map v.role_name
             (fun f -> Query.Pair ("RoleName", (String.to_query f)));
           Util.option_map v.platform
             (fun f -> Query.Pair ("Platform", (String.to_query f)));
           Util.option_map v.license_type
             (fun f -> Query.Pair ("LicenseType", (String.to_query f)));
           Util.option_map v.kms_key_id
             (fun f -> Query.Pair ("KmsKeyId", (String.to_query f)));
           Util.option_map v.hypervisor
             (fun f -> Query.Pair ("Hypervisor", (String.to_query f)));
           Util.option_map v.encrypted
             (fun f -> Query.Pair ("Encrypted", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("DiskContainer",
                  (ImageDiskContainerList.to_query v.disk_containers)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.client_data
             (fun f -> Query.Pair ("ClientData", (ClientData.to_query f)));
           Util.option_map v.architecture
             (fun f -> Query.Pair ("Architecture", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("license_specifications",
                (ImportImageLicenseSpecificationListRequest.to_json
                   v.license_specifications));
           Util.option_map v.role_name
             (fun f -> ("role_name", (String.to_json f)));
           Util.option_map v.platform
             (fun f -> ("platform", (String.to_json f)));
           Util.option_map v.license_type
             (fun f -> ("license_type", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.hypervisor
             (fun f -> ("hypervisor", (String.to_json f)));
           Util.option_map v.encrypted
             (fun f -> ("encrypted", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("disk_containers",
               (ImageDiskContainerList.to_json v.disk_containers));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.client_data
             (fun f -> ("client_data", (ClientData.to_json f)));
           Util.option_map v.architecture
             (fun f -> ("architecture", (String.to_json f)))])
    let parse xml =
      Some
        {
          architecture =
            (Util.option_bind (Xml.member "Architecture" xml) String.parse);
          client_data =
            (Util.option_bind (Xml.member "ClientData" xml) ClientData.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          disk_containers =
            (Util.of_option []
               (Util.option_bind (Xml.member "DiskContainer" xml)
                  ImageDiskContainerList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          encrypted =
            (Util.option_bind (Xml.member "Encrypted" xml) Boolean.parse);
          hypervisor =
            (Util.option_bind (Xml.member "Hypervisor" xml) String.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          license_type =
            (Util.option_bind (Xml.member "LicenseType" xml) String.parse);
          platform =
            (Util.option_bind (Xml.member "Platform" xml) String.parse);
          role_name =
            (Util.option_bind (Xml.member "RoleName" xml) String.parse);
          license_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "LicenseSpecifications" xml)
                  ImportImageLicenseSpecificationListRequest.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Util.option_map v.architecture
                          (fun f ->
                             Ezxmlm.make_tag "Architecture"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.client_data
                         (fun f ->
                            Ezxmlm.make_tag "ClientData"
                              ([], (ClientData.to_xml f)))])
                     @
                     [Util.option_map v.client_token
                        (fun f ->
                           Ezxmlm.make_tag "ClientToken"
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
                           (Ezxmlm.make_tag "DiskContainer"
                              ([], (ImageDiskContainerList.to_xml [x]))))
                      v.disk_containers))
                  @
                  [Util.option_map v.dry_run
                     (fun f ->
                        Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
                 @
                 [Util.option_map v.encrypted
                    (fun f ->
                       Ezxmlm.make_tag "Encrypted" ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.hypervisor
                   (fun f ->
                      Ezxmlm.make_tag "Hypervisor" ([], (String.to_xml f)))])
               @
               [Util.option_map v.kms_key_id
                  (fun f ->
                     Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.license_type
                 (fun f ->
                    Ezxmlm.make_tag "LicenseType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.platform
                (fun f -> Ezxmlm.make_tag "Platform" ([], (String.to_xml f)))])
            @
            [Util.option_map v.role_name
               (fun f -> Ezxmlm.make_tag "RoleName" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LicenseSpecifications"
                      ([],
                        (ImportImageLicenseSpecificationListRequest.to_xml
                           [x])))) v.license_specifications))
  end
module ImportImageResult = ImportImageResult
type input = ImportImageRequest.t
type output = ImportImageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["ImportImage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ImportImageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ImportImageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ImportImageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ImportImageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ImportImageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ImportImageResult - missing field in body or children: "
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