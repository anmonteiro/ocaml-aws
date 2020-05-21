open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ImportVolumeRequest =
  struct
    type t =
      {
      availability_zone: String.t
        [@ocaml.doc
          "<p>The Availability Zone for the resulting EBS volume.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the volume.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      image: DiskImageDetail.t [@ocaml.doc "<p>The disk image.</p>"];
      volume: VolumeDetail.t [@ocaml.doc "<p>The volume size.</p>"]}
    let make ~availability_zone  ?description  ?dry_run  ~image  ~volume  ()
      = { availability_zone; description; dry_run; image; volume }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("Volume", (VolumeDetail.to_query v.volume)));
           Some (Query.Pair ("Image", (DiskImageDetail.to_query v.image)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Some
             (Query.Pair
                ("AvailabilityZone", (String.to_query v.availability_zone)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("volume", (VolumeDetail.to_json v.volume));
           Some ("image", (DiskImageDetail.to_json v.image));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some ("availability_zone", (String.to_json v.availability_zone))])
    let parse xml =
      Some
        {
          availability_zone =
            (Xml.required "availabilityZone"
               (Util.option_bind (Xml.member "availabilityZone" xml)
                  String.parse));
          description =
            (Util.option_bind (Xml.member "description" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          image =
            (Xml.required "image"
               (Util.option_bind (Xml.member "image" xml)
                  DiskImageDetail.parse));
          volume =
            (Xml.required "volume"
               (Util.option_bind (Xml.member "volume" xml) VolumeDetail.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "availabilityZone"
                     ([], (String.to_xml v.availability_zone)))])
              @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "description" ([], (String.to_xml f)))])
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "image"
                  ([], (DiskImageDetail.to_xml v.image)))])
           @
           [Some
              (Ezxmlm.make_tag "volume" ([], (VolumeDetail.to_xml v.volume)))])
  end
module ImportVolumeResult = ImportVolumeResult
type input = ImportVolumeRequest.t
type output = ImportVolumeResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ImportVolume"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ImportVolumeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ImportVolumeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ImportVolumeResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ImportVolumeResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ImportVolumeResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ImportVolumeResult - missing field in body or children: "
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