open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ImportInstanceRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc "<p>A description for the instance being imported.</p>"];
      disk_images: DiskImageList.t [@ocaml.doc "<p>The disk image.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      launch_specification: ImportInstanceLaunchSpecification.t option
        [@ocaml.doc "<p>The launch specification.</p>"];
      platform: PlatformValues.t
        [@ocaml.doc "<p>The instance operating system.</p>"]}
    let make ?description  ?(disk_images= [])  ?dry_run 
      ?launch_specification  ~platform  () =
      { description; disk_images; dry_run; launch_specification; platform }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair ("Platform", (PlatformValues.to_query v.platform)));
           Util.option_map v.launch_specification
             (fun f ->
                Query.Pair
                  ("LaunchSpecification",
                    (ImportInstanceLaunchSpecification.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("DiskImage", (DiskImageList.to_query v.disk_images)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("platform", (PlatformValues.to_json v.platform));
           Util.option_map v.launch_specification
             (fun f ->
                ("launch_specification",
                  (ImportInstanceLaunchSpecification.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("disk_images", (DiskImageList.to_json v.disk_images));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "description" xml) String.parse);
          disk_images =
            (Util.of_option []
               (Util.option_bind (Xml.member "diskImage" xml)
                  DiskImageList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          launch_specification =
            (Util.option_bind (Xml.member "launchSpecification" xml)
               ImportInstanceLaunchSpecification.parse);
          platform =
            (Xml.required "platform"
               (Util.option_bind (Xml.member "platform" xml)
                  PlatformValues.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.description
                  (fun f ->
                     Ezxmlm.make_tag "description" ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "diskImage"
                         ([], (DiskImageList.to_xml [x])))) v.disk_images))
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.launch_specification
               (fun f ->
                  Ezxmlm.make_tag "launchSpecification"
                    ([], (ImportInstanceLaunchSpecification.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "platform"
                 ([], (PlatformValues.to_xml v.platform)))])
  end
module ImportInstanceResult = ImportInstanceResult
type input = ImportInstanceRequest.t
type output = ImportInstanceResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ImportInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ImportInstanceRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ImportInstanceRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ImportInstanceResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ImportInstanceResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ImportInstanceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ImportInstanceResult - missing field in body or children: "
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