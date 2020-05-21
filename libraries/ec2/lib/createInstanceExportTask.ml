open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateInstanceExportTaskRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc
          "<p>A description for the conversion task or the resource being exported. The maximum length is 255 bytes.</p>"];
      export_to_s3_task: ExportToS3TaskSpecification.t option
        [@ocaml.doc
          "<p>The format and location for an instance export task.</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      target_environment: ExportEnvironment.t option
        [@ocaml.doc "<p>The target virtualization environment.</p>"]}
    let make ?description  ?export_to_s3_task  ~instance_id 
      ?target_environment  () =
      { description; export_to_s3_task; instance_id; target_environment }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.target_environment
              (fun f ->
                 Query.Pair
                   ("TargetEnvironment", (ExportEnvironment.to_query f)));
           Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Util.option_map v.export_to_s3_task
             (fun f ->
                Query.Pair
                  ("ExportToS3", (ExportToS3TaskSpecification.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.target_environment
              (fun f -> ("target_environment", (ExportEnvironment.to_json f)));
           Some ("instance_id", (String.to_json v.instance_id));
           Util.option_map v.export_to_s3_task
             (fun f ->
                ("export_to_s3_task",
                  (ExportToS3TaskSpecification.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "description" xml) String.parse);
          export_to_s3_task =
            (Util.option_bind (Xml.member "exportToS3" xml)
               ExportToS3TaskSpecification.parse);
          instance_id =
            (Xml.required "instanceId"
               (Util.option_bind (Xml.member "instanceId" xml) String.parse));
          target_environment =
            (Util.option_bind (Xml.member "targetEnvironment" xml)
               ExportEnvironment.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "description" ([], (String.to_xml f)))])
             @
             [Util.option_map v.export_to_s3_task
                (fun f ->
                   Ezxmlm.make_tag "exportToS3"
                     ([], (ExportToS3TaskSpecification.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "instanceId"
                  ([], (String.to_xml v.instance_id)))])
           @
           [Util.option_map v.target_environment
              (fun f ->
                 Ezxmlm.make_tag "targetEnvironment"
                   ([], (ExportEnvironment.to_xml f)))])
  end
module CreateInstanceExportTaskResult = CreateInstanceExportTaskResult
type input = CreateInstanceExportTaskRequest.t
type output = CreateInstanceExportTaskResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["CreateInstanceExportTask"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateInstanceExportTaskRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateInstanceExportTaskRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateInstanceExportTaskResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateInstanceExportTaskResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateInstanceExportTaskResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateInstanceExportTaskResult - missing field in body or children: "
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