open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RegisterImageRequest =
  struct
    type t =
      {
      image_location: String.t option
        [@ocaml.doc
          "<p>The full path to your AMI manifest in Amazon S3 storage. The specified bucket must have the <code>aws-exec-read</code> canned access control list (ACL) to ensure that it can be accessed by Amazon EC2. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl\">Canned ACLs</a> in the <i>Amazon S3 Service Developer Guide</i>.</p>"];
      architecture: ArchitectureValues.t option
        [@ocaml.doc
          "<p>The architecture of the AMI.</p> <p>Default: For Amazon EBS-backed AMIs, <code>i386</code>. For instance store-backed AMIs, the architecture specified in the manifest file.</p>"];
      block_device_mappings: BlockDeviceMappingRequestList.t
        [@ocaml.doc "<p>The block device mapping entries.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description for your AMI.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      ena_support: Boolean.t option
        [@ocaml.doc
          "<p>Set to <code>true</code> to enable enhanced networking with ENA for the AMI and any instances that you launch from the AMI.</p> <p>This option is supported only for HVM AMIs. Specifying this option with a PV AMI can make instances launched from the AMI unreachable.</p>"];
      kernel_id: String.t option [@ocaml.doc "<p>The ID of the kernel.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>A name for your AMI.</p> <p>Constraints: 3-128 alphanumeric characters, parentheses (()), square brackets ([]), spaces ( ), periods (.), slashes (/), dashes (-), single quotes ('), at-signs (@), or underscores(_)</p>"];
      billing_products: BillingProductList.t
        [@ocaml.doc
          "<p>The billing product codes. Your account must be authorized to specify billing product codes. Otherwise, you can use the AWS Marketplace to bill for the use of an AMI.</p>"];
      ramdisk_id: String.t option
        [@ocaml.doc "<p>The ID of the RAM disk.</p>"];
      root_device_name: String.t option
        [@ocaml.doc
          "<p>The device name of the root device volume (for example, <code>/dev/sda1</code>).</p>"];
      sriov_net_support: String.t option
        [@ocaml.doc
          "<p>Set to <code>simple</code> to enable enhanced networking with the Intel 82599 Virtual Function interface for the AMI and any instances that you launch from the AMI.</p> <p>There is no way to disable <code>sriovNetSupport</code> at this time.</p> <p>This option is supported only for HVM AMIs. Specifying this option with a PV AMI can make instances launched from the AMI unreachable.</p>"];
      virtualization_type: String.t option
        [@ocaml.doc
          "<p>The type of virtualization (<code>hvm</code> | <code>paravirtual</code>).</p> <p>Default: <code>paravirtual</code> </p>"]}
    [@@ocaml.doc "<p>Contains the parameters for RegisterImage.</p>"]
    let make ?image_location  ?architecture  ?(block_device_mappings= []) 
      ?description  ?dry_run  ?ena_support  ?kernel_id  ~name 
      ?(billing_products= [])  ?ramdisk_id  ?root_device_name 
      ?sriov_net_support  ?virtualization_type  () =
      {
        image_location;
        architecture;
        block_device_mappings;
        description;
        dry_run;
        ena_support;
        kernel_id;
        name;
        billing_products;
        ramdisk_id;
        root_device_name;
        sriov_net_support;
        virtualization_type
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.virtualization_type
              (fun f ->
                 Query.Pair ("VirtualizationType", (String.to_query f)));
           Util.option_map v.sriov_net_support
             (fun f -> Query.Pair ("SriovNetSupport", (String.to_query f)));
           Util.option_map v.root_device_name
             (fun f -> Query.Pair ("RootDeviceName", (String.to_query f)));
           Util.option_map v.ramdisk_id
             (fun f -> Query.Pair ("RamdiskId", (String.to_query f)));
           Some
             (Query.Pair
                ("BillingProduct",
                  (BillingProductList.to_query v.billing_products)));
           Some (Query.Pair ("Name", (String.to_query v.name)));
           Util.option_map v.kernel_id
             (fun f -> Query.Pair ("KernelId", (String.to_query f)));
           Util.option_map v.ena_support
             (fun f -> Query.Pair ("EnaSupport", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Some
             (Query.Pair
                ("BlockDeviceMapping",
                  (BlockDeviceMappingRequestList.to_query
                     v.block_device_mappings)));
           Util.option_map v.architecture
             (fun f ->
                Query.Pair ("Architecture", (ArchitectureValues.to_query f)));
           Util.option_map v.image_location
             (fun f -> Query.Pair ("ImageLocation", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.virtualization_type
              (fun f -> ("virtualization_type", (String.to_json f)));
           Util.option_map v.sriov_net_support
             (fun f -> ("sriov_net_support", (String.to_json f)));
           Util.option_map v.root_device_name
             (fun f -> ("root_device_name", (String.to_json f)));
           Util.option_map v.ramdisk_id
             (fun f -> ("ramdisk_id", (String.to_json f)));
           Some
             ("billing_products",
               (BillingProductList.to_json v.billing_products));
           Some ("name", (String.to_json v.name));
           Util.option_map v.kernel_id
             (fun f -> ("kernel_id", (String.to_json f)));
           Util.option_map v.ena_support
             (fun f -> ("ena_support", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some
             ("block_device_mappings",
               (BlockDeviceMappingRequestList.to_json v.block_device_mappings));
           Util.option_map v.architecture
             (fun f -> ("architecture", (ArchitectureValues.to_json f)));
           Util.option_map v.image_location
             (fun f -> ("image_location", (String.to_json f)))])
    let parse xml =
      Some
        {
          image_location =
            (Util.option_bind (Xml.member "ImageLocation" xml) String.parse);
          architecture =
            (Util.option_bind (Xml.member "architecture" xml)
               ArchitectureValues.parse);
          block_device_mappings =
            (Util.of_option []
               (Util.option_bind (Xml.member "BlockDeviceMapping" xml)
                  BlockDeviceMappingRequestList.parse));
          description =
            (Util.option_bind (Xml.member "description" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          ena_support =
            (Util.option_bind (Xml.member "enaSupport" xml) Boolean.parse);
          kernel_id =
            (Util.option_bind (Xml.member "kernelId" xml) String.parse);
          name =
            (Xml.required "name"
               (Util.option_bind (Xml.member "name" xml) String.parse));
          billing_products =
            (Util.of_option []
               (Util.option_bind (Xml.member "BillingProduct" xml)
                  BillingProductList.parse));
          ramdisk_id =
            (Util.option_bind (Xml.member "ramdiskId" xml) String.parse);
          root_device_name =
            (Util.option_bind (Xml.member "rootDeviceName" xml) String.parse);
          sriov_net_support =
            (Util.option_bind (Xml.member "sriovNetSupport" xml) String.parse);
          virtualization_type =
            (Util.option_bind (Xml.member "virtualizationType" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Util.option_map v.image_location
                          (fun f ->
                             Ezxmlm.make_tag "ImageLocation"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.architecture
                         (fun f ->
                            Ezxmlm.make_tag "architecture"
                              ([], (ArchitectureValues.to_xml f)))])
                     @
                     (List.map
                        (fun x ->
                           Some
                             (Ezxmlm.make_tag "BlockDeviceMapping"
                                ([],
                                  (BlockDeviceMappingRequestList.to_xml [x]))))
                        v.block_device_mappings))
                    @
                    [Util.option_map v.description
                       (fun f ->
                          Ezxmlm.make_tag "description"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.dry_run
                      (fun f ->
                         Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                  @
                  [Util.option_map v.ena_support
                     (fun f ->
                        Ezxmlm.make_tag "enaSupport" ([], (Boolean.to_xml f)))])
                 @
                 [Util.option_map v.kernel_id
                    (fun f ->
                       Ezxmlm.make_tag "kernelId" ([], (String.to_xml f)))])
                @
                [Some (Ezxmlm.make_tag "name" ([], (String.to_xml v.name)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "BillingProduct"
                          ([], (BillingProductList.to_xml [x]))))
                  v.billing_products))
              @
              [Util.option_map v.ramdisk_id
                 (fun f ->
                    Ezxmlm.make_tag "ramdiskId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.root_device_name
                (fun f ->
                   Ezxmlm.make_tag "rootDeviceName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.sriov_net_support
               (fun f ->
                  Ezxmlm.make_tag "sriovNetSupport" ([], (String.to_xml f)))])
           @
           [Util.option_map v.virtualization_type
              (fun f ->
                 Ezxmlm.make_tag "virtualizationType" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for RegisterImage.</p>"]
module RegisterImageResult = RegisterImageResult
type input = RegisterImageRequest.t
type output = RegisterImageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["RegisterImage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RegisterImageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (RegisterImageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "RegisterImageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp RegisterImageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed RegisterImageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RegisterImageResult - missing field in body or children: "
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