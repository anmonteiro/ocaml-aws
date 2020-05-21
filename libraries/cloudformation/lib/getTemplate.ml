open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetTemplateInput =
  struct
    type t =
      {
      stack_name: String.t option
        [@ocaml.doc
          "<p>The name or the unique stack ID that is associated with the stack, which are not always interchangeable:</p> <ul> <li> <p>Running stacks: You can specify either the stack's name or its unique stack ID.</p> </li> <li> <p>Deleted stacks: You must specify the unique stack ID.</p> </li> </ul> <p>Default: There is no default value.</p>"];
      change_set_name: String.t option
        [@ocaml.doc
          "<p>The name or Amazon Resource Name (ARN) of a change set for which AWS CloudFormation returns the associated template. If you specify a name, you must also specify the <code>StackName</code>.</p>"];
      template_stage: TemplateStage.t option
        [@ocaml.doc
          "<p>For templates that include transforms, the stage of the template that AWS CloudFormation returns. To get the user-submitted template, specify <code>Original</code>. To get the template after AWS CloudFormation has processed all transforms, specify <code>Processed</code>. </p> <p>If the template doesn't include transforms, <code>Original</code> and <code>Processed</code> return the same template. By default, AWS CloudFormation specifies <code>Original</code>. </p>"]}
    [@@ocaml.doc "<p>The input for a <a>GetTemplate</a> action.</p>"]
    let make ?stack_name  ?change_set_name  ?template_stage  () =
      { stack_name; change_set_name; template_stage }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.template_stage
              (fun f -> ("template_stage", (TemplateStage.to_json f)));
           Util.option_map v.change_set_name
             (fun f -> ("change_set_name", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          change_set_name =
            (Util.option_bind (Xml.member "ChangeSetName" xml) String.parse);
          template_stage =
            (Util.option_bind (Xml.member "TemplateStage" xml)
               TemplateStage.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.stack_name
                (fun f -> Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.change_set_name
               (fun f ->
                  Ezxmlm.make_tag "ChangeSetName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.template_stage
              (fun f ->
                 Ezxmlm.make_tag "TemplateStage"
                   ([], (TemplateStage.to_xml f)))])
  end[@@ocaml.doc "<p>The input for a <a>GetTemplate</a> action.</p>"]
module GetTemplateOutput = GetTemplateOutput
type input = GetTemplateInput.t
type output = GetTemplateOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2010-05-15"]); ("Action", ["GetTemplate"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetTemplateInput.to_query req))))) in
  (`POST, uri, (Headers.render (GetTemplateInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetTemplateResponse" (snd xml))
        (Xml.member "GetTemplateResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetTemplateOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetTemplateOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetTemplateOutput - missing field in body or children: "
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