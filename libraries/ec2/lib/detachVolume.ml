open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DetachVolumeRequest =
  struct
    type t =
      {
      device: String.t option [@ocaml.doc "<p>The device name.</p>"];
      force: Boolean.t option
        [@ocaml.doc
          "<p>Forces detachment if the previous detachment attempt did not occur cleanly (for example, logging into an instance, unmounting the volume, and detaching normally). This option can lead to data loss or a corrupted file system. Use this option only as a last resort to detach a volume from a failed instance. The instance won't have an opportunity to flush file system caches or file system metadata. If you use this option, you must perform file system check and repair procedures.</p>"];
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of the instance.</p>"];
      volume_id: String.t [@ocaml.doc "<p>The ID of the volume.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?device  ?force  ?instance_id  ~volume_id  ?dry_run  () =
      { device; force; instance_id; volume_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("VolumeId", (String.to_query v.volume_id)));
           Util.option_map v.instance_id
             (fun f -> Query.Pair ("InstanceId", (String.to_query f)));
           Util.option_map v.force
             (fun f -> Query.Pair ("Force", (Boolean.to_query f)));
           Util.option_map v.device
             (fun f -> Query.Pair ("Device", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("volume_id", (String.to_json v.volume_id));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Util.option_map v.device (fun f -> ("device", (String.to_json f)))])
    let parse xml =
      Some
        {
          device = (Util.option_bind (Xml.member "Device" xml) String.parse);
          force = (Util.option_bind (Xml.member "Force" xml) Boolean.parse);
          instance_id =
            (Util.option_bind (Xml.member "InstanceId" xml) String.parse);
          volume_id =
            (Xml.required "VolumeId"
               (Util.option_bind (Xml.member "VolumeId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.device
                  (fun f -> Ezxmlm.make_tag "Device" ([], (String.to_xml f)))])
              @
              [Util.option_map v.force
                 (fun f -> Ezxmlm.make_tag "Force" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.instance_id
                (fun f ->
                   Ezxmlm.make_tag "InstanceId" ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "VolumeId" ([], (String.to_xml v.volume_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module VolumeAttachment = VolumeAttachment
type input = DetachVolumeRequest.t
type output = VolumeAttachment.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DetachVolume"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DetachVolumeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DetachVolumeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DetachVolumeResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp VolumeAttachment.parse)
          (BadResponse
             { body; message = "Could not find well formed VolumeAttachment."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing VolumeAttachment - missing field in body or children: "
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