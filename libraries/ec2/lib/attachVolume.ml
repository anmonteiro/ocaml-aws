open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AttachVolumeRequest =
  struct
    type t =
      {
      device: String.t
        [@ocaml.doc
          "<p>The device name (for example, <code>/dev/sdh</code> or <code>xvdh</code>).</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      volume_id: String.t
        [@ocaml.doc
          "<p>The ID of the EBS volume. The volume and instance must be within the same Availability Zone.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~device  ~instance_id  ~volume_id  ?dry_run  () =
      { device; instance_id; volume_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("VolumeId", (String.to_query v.volume_id)));
           Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Some (Query.Pair ("Device", (String.to_query v.device)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("volume_id", (String.to_json v.volume_id));
           Some ("instance_id", (String.to_json v.instance_id));
           Some ("device", (String.to_json v.device))])
    let parse xml =
      Some
        {
          device =
            (Xml.required "Device"
               (Util.option_bind (Xml.member "Device" xml) String.parse));
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          volume_id =
            (Xml.required "VolumeId"
               (Util.option_bind (Xml.member "VolumeId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Device" ([], (String.to_xml v.device)))])
             @
             [Some
                (Ezxmlm.make_tag "InstanceId"
                   ([], (String.to_xml v.instance_id)))])
            @
            [Some
               (Ezxmlm.make_tag "VolumeId" ([], (String.to_xml v.volume_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module VolumeAttachment = VolumeAttachment
type input = AttachVolumeRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["AttachVolume"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AttachVolumeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AttachVolumeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AttachVolumeResponse" (snd xml) in
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