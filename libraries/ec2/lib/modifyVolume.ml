open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVolumeRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      volume_id: String.t [@ocaml.doc "<p>The ID of the volume.</p>"];
      size: Integer.t option
        [@ocaml.doc
          "<p>The target size of the volume, in GiB. The target volume size must be greater than or equal to than the existing size of the volume. For information about available EBS volume sizes, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html\">Amazon EBS Volume Types</a>.</p> <p>Default: If no size is specified, the existing size is retained.</p>"];
      volume_type: VolumeType.t option
        [@ocaml.doc
          "<p>The target EBS volume type of the volume.</p> <p>Default: If no type is specified, the existing type is retained.</p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The target IOPS rate of the volume.</p> <p>This is only valid for Provisioned IOPS SSD (<code>io1</code>) volumes. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html#EBSVolumeTypes_piops\">Provisioned IOPS SSD (io1) Volumes</a>.</p> <p>Default: If no IOPS value is specified, the existing value is retained.</p>"]}
    let make ?dry_run  ~volume_id  ?size  ?volume_type  ?iops  () =
      { dry_run; volume_id; size; volume_type; iops }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.iops
              (fun f -> Query.Pair ("Iops", (Integer.to_query f)));
           Util.option_map v.volume_type
             (fun f -> Query.Pair ("VolumeType", (VolumeType.to_query f)));
           Util.option_map v.size
             (fun f -> Query.Pair ("Size", (Integer.to_query f)));
           Some (Query.Pair ("VolumeId", (String.to_query v.volume_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.volume_type
             (fun f -> ("volume_type", (VolumeType.to_json f)));
           Util.option_map v.size (fun f -> ("size", (Integer.to_json f)));
           Some ("volume_id", (String.to_json v.volume_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          volume_id =
            (Xml.required "VolumeId"
               (Util.option_bind (Xml.member "VolumeId" xml) String.parse));
          size = (Util.option_bind (Xml.member "Size" xml) Integer.parse);
          volume_type =
            (Util.option_bind (Xml.member "VolumeType" xml) VolumeType.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.dry_run
                  (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "VolumeId"
                    ([], (String.to_xml v.volume_id)))])
             @
             [Util.option_map v.size
                (fun f -> Ezxmlm.make_tag "Size" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.volume_type
               (fun f ->
                  Ezxmlm.make_tag "VolumeType" ([], (VolumeType.to_xml f)))])
           @
           [Util.option_map v.iops
              (fun f -> Ezxmlm.make_tag "Iops" ([], (Integer.to_xml f)))])
  end
module ModifyVolumeResult = ModifyVolumeResult
type input = ModifyVolumeRequest.t
type output = ModifyVolumeResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ModifyVolume"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyVolumeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyVolumeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyVolumeResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyVolumeResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ModifyVolumeResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyVolumeResult - missing field in body or children: "
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