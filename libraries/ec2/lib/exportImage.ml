open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ExportImageRequest =
  struct
    type t =
      {
      client_token: String.t option
        [@ocaml.doc
          "<p>Token to enable idempotency for export image requests.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description of the image being exported. The maximum length is 255 bytes.</p>"];
      disk_image_format: DiskImageFormat.t
        [@ocaml.doc "<p>The disk image format.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      image_id: String.t [@ocaml.doc "<p>The ID of the image.</p>"];
      s3_export_location: ExportTaskS3LocationRequest.t
        [@ocaml.doc
          "<p>Information about the destination S3 bucket. The bucket must exist and grant WRITE and READ_ACP permissions to the AWS account vm-import-export@amazon.com.</p>"];
      role_name: String.t option
        [@ocaml.doc
          "<p>The name of the role that grants VM Import/Export permission to export images to your S3 bucket. If this parameter is not specified, the default role is named 'vmimport'.</p>"]}
    let make ?client_token  ?description  ~disk_image_format  ?dry_run 
      ~image_id  ~s3_export_location  ?role_name  () =
      {
        client_token;
        description;
        disk_image_format;
        dry_run;
        image_id;
        s3_export_location;
        role_name
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.role_name
              (fun f -> Query.Pair ("RoleName", (String.to_query f)));
           Some
             (Query.Pair
                ("S3ExportLocation",
                  (ExportTaskS3LocationRequest.to_query v.s3_export_location)));
           Some (Query.Pair ("ImageId", (String.to_query v.image_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("DiskImageFormat",
                  (DiskImageFormat.to_query v.disk_image_format)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.role_name
              (fun f -> ("role_name", (String.to_json f)));
           Some
             ("s3_export_location",
               (ExportTaskS3LocationRequest.to_json v.s3_export_location));
           Some ("image_id", (String.to_json v.image_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("disk_image_format",
               (DiskImageFormat.to_json v.disk_image_format));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          disk_image_format =
            (Xml.required "DiskImageFormat"
               (Util.option_bind (Xml.member "DiskImageFormat" xml)
                  DiskImageFormat.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          image_id =
            (Xml.required "ImageId"
               (Util.option_bind (Xml.member "ImageId" xml) String.parse));
          s3_export_location =
            (Xml.required "S3ExportLocation"
               (Util.option_bind (Xml.member "S3ExportLocation" xml)
                  ExportTaskS3LocationRequest.parse));
          role_name =
            (Util.option_bind (Xml.member "RoleName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.client_token
                    (fun f ->
                       Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
                @
                [Util.option_map v.description
                   (fun f ->
                      Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "DiskImageFormat"
                     ([], (DiskImageFormat.to_xml v.disk_image_format)))])
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "ImageId" ([], (String.to_xml v.image_id)))])
            @
            [Some
               (Ezxmlm.make_tag "S3ExportLocation"
                  ([],
                    (ExportTaskS3LocationRequest.to_xml v.s3_export_location)))])
           @
           [Util.option_map v.role_name
              (fun f -> Ezxmlm.make_tag "RoleName" ([], (String.to_xml f)))])
  end
module ExportImageResult = ExportImageResult
type input = ExportImageRequest.t
type output = ExportImageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["ExportImage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ExportImageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ExportImageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ExportImageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ExportImageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ExportImageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ExportImageResult - missing field in body or children: "
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