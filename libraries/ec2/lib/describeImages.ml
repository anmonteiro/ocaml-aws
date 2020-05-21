open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeImagesRequest =
  struct
    type t =
      {
      executable_users: ExecutableByStringList.t
        [@ocaml.doc
          "<p>Scopes the images by users with explicit launch permissions. Specify an AWS account ID, <code>self</code> (the sender of the request), or <code>all</code> (public AMIs).</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>architecture</code> - The image architecture (<code>i386</code> | <code>x86_64</code> | <code>arm64</code>).</p> </li> <li> <p> <code>block-device-mapping.delete-on-termination</code> - A Boolean value that indicates whether the Amazon EBS volume is deleted on instance termination.</p> </li> <li> <p> <code>block-device-mapping.device-name</code> - The device name specified in the block device mapping (for example, <code>/dev/sdh</code> or <code>xvdh</code>).</p> </li> <li> <p> <code>block-device-mapping.snapshot-id</code> - The ID of the snapshot used for the EBS volume.</p> </li> <li> <p> <code>block-device-mapping.volume-size</code> - The volume size of the EBS volume, in GiB.</p> </li> <li> <p> <code>block-device-mapping.volume-type</code> - The volume type of the EBS volume (<code>gp2</code> | <code>io1</code> | <code>st1 </code>| <code>sc1</code> | <code>standard</code>).</p> </li> <li> <p> <code>block-device-mapping.encrypted</code> - A Boolean that indicates whether the EBS volume is encrypted.</p> </li> <li> <p> <code>description</code> - The description of the image (provided during image creation).</p> </li> <li> <p> <code>ena-support</code> - A Boolean that indicates whether enhanced networking with ENA is enabled.</p> </li> <li> <p> <code>hypervisor</code> - The hypervisor type (<code>ovm</code> | <code>xen</code>).</p> </li> <li> <p> <code>image-id</code> - The ID of the image.</p> </li> <li> <p> <code>image-type</code> - The image type (<code>machine</code> | <code>kernel</code> | <code>ramdisk</code>).</p> </li> <li> <p> <code>is-public</code> - A Boolean that indicates whether the image is public.</p> </li> <li> <p> <code>kernel-id</code> - The kernel ID.</p> </li> <li> <p> <code>manifest-location</code> - The location of the image manifest.</p> </li> <li> <p> <code>name</code> - The name of the AMI (provided during image creation).</p> </li> <li> <p> <code>owner-alias</code> - String value from an Amazon-maintained list (<code>amazon</code> | <code>aws-marketplace</code> | <code>microsoft</code>) of snapshot owners. Not to be confused with the user-configured AWS account alias, which is set from the IAM console.</p> </li> <li> <p> <code>owner-id</code> - The AWS account ID of the image owner.</p> </li> <li> <p> <code>platform</code> - The platform. To only list Windows-based AMIs, use <code>windows</code>.</p> </li> <li> <p> <code>product-code</code> - The product code.</p> </li> <li> <p> <code>product-code.type</code> - The type of the product code (<code>devpay</code> | <code>marketplace</code>).</p> </li> <li> <p> <code>ramdisk-id</code> - The RAM disk ID.</p> </li> <li> <p> <code>root-device-name</code> - The device name of the root device volume (for example, <code>/dev/sda1</code>).</p> </li> <li> <p> <code>root-device-type</code> - The type of the root device volume (<code>ebs</code> | <code>instance-store</code>).</p> </li> <li> <p> <code>state</code> - The state of the image (<code>available</code> | <code>pending</code> | <code>failed</code>).</p> </li> <li> <p> <code>state-reason-code</code> - The reason code for the state change.</p> </li> <li> <p> <code>state-reason-message</code> - The message for the state change.</p> </li> <li> <p> <code>sriov-net-support</code> - A value of <code>simple</code> indicates that enhanced networking with the Intel 82599 VF interface is enabled.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>virtualization-type</code> - The virtualization type (<code>paravirtual</code> | <code>hvm</code>).</p> </li> </ul>"];
      image_ids: ImageIdStringList.t
        [@ocaml.doc
          "<p>The image IDs.</p> <p>Default: Describes all images available to you.</p>"];
      owners: OwnerStringList.t
        [@ocaml.doc
          "<p>Filters the images by the owner. Specify an AWS account ID, <code>self</code> (owner is the sender of the request), or an AWS owner alias (valid values are <code>amazon</code> | <code>aws-marketplace</code> | <code>microsoft</code>). Omitting this option returns all images for which you have launch permissions, regardless of ownership.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(executable_users= [])  ?(filters= [])  ?(image_ids= []) 
      ?(owners= [])  ?dry_run  () =
      { executable_users; filters; image_ids; owners; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Owner", (OwnerStringList.to_query v.owners)));
           Some
             (Query.Pair
                ("ImageId", (ImageIdStringList.to_query v.image_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("ExecutableBy",
                  (ExecutableByStringList.to_query v.executable_users)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("owners", (OwnerStringList.to_json v.owners));
           Some ("image_ids", (ImageIdStringList.to_json v.image_ids));
           Some ("filters", (FilterList.to_json v.filters));
           Some
             ("executable_users",
               (ExecutableByStringList.to_json v.executable_users))])
    let parse xml =
      Some
        {
          executable_users =
            (Util.of_option []
               (Util.option_bind (Xml.member "ExecutableBy" xml)
                  ExecutableByStringList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          image_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ImageId" xml)
                  ImageIdStringList.parse));
          owners =
            (Util.of_option []
               (Util.option_bind (Xml.member "Owner" xml)
                  OwnerStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ExecutableBy"
                          ([], (ExecutableByStringList.to_xml [x]))))
                  v.executable_users))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filters))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ImageId"
                        ([], (ImageIdStringList.to_xml [x])))) v.image_ids))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Owner"
                       ([], (OwnerStringList.to_xml [x])))) v.owners))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeImagesResult = DescribeImagesResult
type input = DescribeImagesRequest.t
type output = DescribeImagesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeImages"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeImagesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeImagesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeImagesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeImagesResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeImagesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeImagesResult - missing field in body or children: "
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