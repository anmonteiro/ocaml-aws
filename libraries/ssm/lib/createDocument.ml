open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDocumentRequest =
  struct
    type t =
      {
      content: String.t [@ocaml.doc "<p>A valid JSON or YAML string.</p>"];
      requires: DocumentRequiresList.t
        [@ocaml.doc
          "<p>A list of SSM documents required by a document. For example, an <code>ApplicationConfiguration</code> document requires an <code>ApplicationConfigurationSchema</code> document.</p>"];
      attachments: AttachmentsSourceList.t
        [@ocaml.doc
          "<p>A list of key and value pairs that describe attachments to a version of a document.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>A name for the Systems Manager document.</p> <important> <p>Do not use the following to begin the names of documents you create. They are reserved by AWS for use as document prefixes:</p> <ul> <li> <p> <code>aws</code> </p> </li> <li> <p> <code>amazon</code> </p> </li> <li> <p> <code>amzn</code> </p> </li> </ul> </important>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>An optional field specifying the version of the artifact you are creating with the document. For example, \"Release 12, Update 6\". This value is unique across all versions of a document, and cannot be changed.</p>"];
      document_type: DocumentType.t option
        [@ocaml.doc
          "<p>The type of document to create. Valid document types include: <code>Command</code>, <code>Policy</code>, <code>Automation</code>, <code>Session</code>, and <code>Package</code>.</p>"];
      document_format: DocumentFormat.t option
        [@ocaml.doc
          "<p>Specify the document format for the request. The document format can be JSON, YAML, or TEXT. JSON is the default format.</p>"];
      target_type: String.t option
        [@ocaml.doc
          "<p>Specify a target type to define the kinds of resources the document can run on. For example, to run a document on EC2 instances, specify the following value: /AWS::EC2::Instance. If you specify a value of '/' the document can run on all types of resources. If you don't specify a value, the document can't run on any resources. For a list of valid resource types, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\">AWS Resource Types Reference</a> in the <i>AWS CloudFormation User Guide</i>. </p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>Optional metadata that you assign to a resource. Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment. For example, you might want to tag an SSM document to identify the types of targets or the environment where it will run. In this case, you could specify the following key name/value pairs:</p> <ul> <li> <p> <code>Key=OS,Value=Windows</code> </p> </li> <li> <p> <code>Key=Environment,Value=Production</code> </p> </li> </ul> <note> <p>To add tags to an existing SSM document, use the <a>AddTagsToResource</a> action.</p> </note>"]}
    let make ~content  ?(requires= [])  ?(attachments= [])  ~name 
      ?version_name  ?document_type  ?document_format  ?target_type  ?(tags=
      [])  () =
      {
        content;
        requires;
        attachments;
        name;
        version_name;
        document_type;
        document_format;
        target_type;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.target_type
             (fun f -> ("target_type", (String.to_json f)));
           Util.option_map v.document_format
             (fun f -> ("document_format", (DocumentFormat.to_json f)));
           Util.option_map v.document_type
             (fun f -> ("document_type", (DocumentType.to_json f)));
           Util.option_map v.version_name
             (fun f -> ("version_name", (String.to_json f)));
           Some ("name", (String.to_json v.name));
           Some
             ("attachments", (AttachmentsSourceList.to_json v.attachments));
           Some ("requires", (DocumentRequiresList.to_json v.requires));
           Some ("content", (String.to_json v.content))])
    let of_json j =
      {
        content =
          (String.of_json (Util.of_option_exn (Json.lookup j "content")));
        requires =
          (DocumentRequiresList.of_json
             (Util.of_option_exn (Json.lookup j "requires")));
        attachments =
          (AttachmentsSourceList.of_json
             (Util.of_option_exn (Json.lookup j "attachments")));
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        version_name =
          (Util.option_map (Json.lookup j "version_name") String.of_json);
        document_type =
          (Util.option_map (Json.lookup j "document_type")
             DocumentType.of_json);
        document_format =
          (Util.option_map (Json.lookup j "document_format")
             DocumentFormat.of_json);
        target_type =
          (Util.option_map (Json.lookup j "target_type") String.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module CreateDocumentResult = CreateDocumentResult
type input = CreateDocumentRequest.t
type output = CreateDocumentResult.t
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateDocumentRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CreateDocumentRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (CreateDocumentResult.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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