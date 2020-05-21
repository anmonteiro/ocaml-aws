open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateFpgaImageRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      input_storage_location: StorageLocation.t
        [@ocaml.doc
          "<p>The location of the encrypted design checkpoint in Amazon S3. The input must be a tarball.</p>"];
      logs_storage_location: StorageLocation.t option
        [@ocaml.doc "<p>The location in Amazon S3 for the output logs.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description for the AFI.</p>"];
      name: String.t option [@ocaml.doc "<p>A name for the AFI.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to apply to the FPGA image during creation.</p>"]}
    let make ?dry_run  ~input_storage_location  ?logs_storage_location 
      ?description  ?name  ?client_token  ?(tag_specifications= [])  () =
      {
        dry_run;
        input_storage_location;
        logs_storage_location;
        description;
        name;
        client_token;
        tag_specifications
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TagSpecification",
                   (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.name
             (fun f -> Query.Pair ("Name", (String.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.logs_storage_location
             (fun f ->
                Query.Pair
                  ("LogsStorageLocation", (StorageLocation.to_query f)));
           Some
             (Query.Pair
                ("InputStorageLocation",
                  (StorageLocation.to_query v.input_storage_location)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("tag_specifications",
                (TagSpecificationList.to_json v.tag_specifications));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.logs_storage_location
             (fun f -> ("logs_storage_location", (StorageLocation.to_json f)));
           Some
             ("input_storage_location",
               (StorageLocation.to_json v.input_storage_location));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          input_storage_location =
            (Xml.required "InputStorageLocation"
               (Util.option_bind (Xml.member "InputStorageLocation" xml)
                  StorageLocation.parse));
          logs_storage_location =
            (Util.option_bind (Xml.member "LogsStorageLocation" xml)
               StorageLocation.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.dry_run
                    (fun f ->
                       Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
                @
                [Some
                   (Ezxmlm.make_tag "InputStorageLocation"
                      ([], (StorageLocation.to_xml v.input_storage_location)))])
               @
               [Util.option_map v.logs_storage_location
                  (fun f ->
                     Ezxmlm.make_tag "LogsStorageLocation"
                       ([], (StorageLocation.to_xml f)))])
              @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
             @
             [Util.option_map v.name
                (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
            @
            [Util.option_map v.client_token
               (fun f ->
                  Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TagSpecification"
                      ([], (TagSpecificationList.to_xml [x]))))
              v.tag_specifications))
  end
module CreateFpgaImageResult = CreateFpgaImageResult
type input = CreateFpgaImageRequest.t
type output = CreateFpgaImageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateFpgaImage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateFpgaImageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateFpgaImageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateFpgaImageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateFpgaImageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateFpgaImageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateFpgaImageResult - missing field in body or children: "
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