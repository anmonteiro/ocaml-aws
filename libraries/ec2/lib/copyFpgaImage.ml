open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopyFpgaImageRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      source_fpga_image_id: String.t
        [@ocaml.doc "<p>The ID of the source AFI.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description for the new AFI.</p>"];
      name: String.t option
        [@ocaml.doc
          "<p>The name for the new AFI. The default is the name of the source AFI.</p>"];
      source_region: String.t
        [@ocaml.doc "<p>The Region that contains the source AFI.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"]}
    let make ?dry_run  ~source_fpga_image_id  ?description  ?name 
      ~source_region  ?client_token  () =
      {
        dry_run;
        source_fpga_image_id;
        description;
        name;
        source_region;
        client_token
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Some
             (Query.Pair ("SourceRegion", (String.to_query v.source_region)));
           Util.option_map v.name
             (fun f -> Query.Pair ("Name", (String.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Some
             (Query.Pair
                ("SourceFpgaImageId",
                  (String.to_query v.source_fpga_image_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Some ("source_region", (String.to_json v.source_region));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some
             ("source_fpga_image_id",
               (String.to_json v.source_fpga_image_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          source_fpga_image_id =
            (Xml.required "SourceFpgaImageId"
               (Util.option_bind (Xml.member "SourceFpgaImageId" xml)
                  String.parse));
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          source_region =
            (Xml.required "SourceRegion"
               (Util.option_bind (Xml.member "SourceRegion" xml) String.parse));
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.dry_run
                   (fun f ->
                      Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "SourceFpgaImageId"
                     ([], (String.to_xml v.source_fpga_image_id)))])
              @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
             @
             [Util.option_map v.name
                (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "SourceRegion"
                  ([], (String.to_xml v.source_region)))])
           @
           [Util.option_map v.client_token
              (fun f -> Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
  end
module CopyFpgaImageResult = CopyFpgaImageResult
type input = CopyFpgaImageRequest.t
type output = CopyFpgaImageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CopyFpgaImage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopyFpgaImageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CopyFpgaImageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CopyFpgaImageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CopyFpgaImageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CopyFpgaImageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopyFpgaImageResult - missing field in body or children: "
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