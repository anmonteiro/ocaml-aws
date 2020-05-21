open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateImageRequest =
  struct
    type t =
      {
      block_device_mappings: BlockDeviceMappingRequestList.t
        [@ocaml.doc
          "<p>The block device mappings. This parameter cannot be used to modify the encryption status of existing volumes or snapshots. To create an AMI with encrypted snapshots, use the <a>CopyImage</a> action.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description for the new image.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>A name for the new image.</p> <p>Constraints: 3-128 alphanumeric characters, parentheses (()), square brackets ([]), spaces ( ), periods (.), slashes (/), dashes (-), single quotes ('), at-signs (@), or underscores(_)</p>"];
      no_reboot: Boolean.t option
        [@ocaml.doc
          "<p>By default, Amazon EC2 attempts to shut down and reboot the instance before creating the image. If the 'No Reboot' option is set, Amazon EC2 doesn't shut down the instance before creating the image. When this option is used, file system integrity on the created image can't be guaranteed.</p>"]}
    let make ?(block_device_mappings= [])  ?description  ?dry_run 
      ~instance_id  ~name  ?no_reboot  () =
      {
        block_device_mappings;
        description;
        dry_run;
        instance_id;
        name;
        no_reboot
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.no_reboot
              (fun f -> Query.Pair ("NoReboot", (Boolean.to_query f)));
           Some (Query.Pair ("Name", (String.to_query v.name)));
           Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Some
             (Query.Pair
                ("BlockDeviceMapping",
                  (BlockDeviceMappingRequestList.to_query
                     v.block_device_mappings)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.no_reboot
              (fun f -> ("no_reboot", (Boolean.to_json f)));
           Some ("name", (String.to_json v.name));
           Some ("instance_id", (String.to_json v.instance_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some
             ("block_device_mappings",
               (BlockDeviceMappingRequestList.to_json v.block_device_mappings))])
    let parse xml =
      Some
        {
          block_device_mappings =
            (Util.of_option []
               (Util.option_bind (Xml.member "blockDeviceMapping" xml)
                  BlockDeviceMappingRequestList.parse));
          description =
            (Util.option_bind (Xml.member "description" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          instance_id =
            (Xml.required "instanceId"
               (Util.option_bind (Xml.member "instanceId" xml) String.parse));
          name =
            (Xml.required "name"
               (Util.option_bind (Xml.member "name" xml) String.parse));
          no_reboot =
            (Util.option_bind (Xml.member "noReboot" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "blockDeviceMapping"
                           ([], (BlockDeviceMappingRequestList.to_xml [x]))))
                   v.block_device_mappings))
               @
               [Util.option_map v.description
                  (fun f ->
                     Ezxmlm.make_tag "description" ([], (String.to_xml f)))])
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "instanceId"
                   ([], (String.to_xml v.instance_id)))])
            @ [Some (Ezxmlm.make_tag "name" ([], (String.to_xml v.name)))])
           @
           [Util.option_map v.no_reboot
              (fun f -> Ezxmlm.make_tag "noReboot" ([], (Boolean.to_xml f)))])
  end
module CreateImageResult = CreateImageResult
type input = CreateImageRequest.t
type output = CreateImageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["CreateImage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateImageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateImageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateImageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateImageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateImageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateImageResult - missing field in body or children: "
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