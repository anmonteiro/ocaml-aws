open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ValidateTemplateInput =
  struct
    type t =
      {
      template_body: String.t option
        [@ocaml.doc
          "<p>Structure containing the template body with a minimum length of 1 byte and a maximum length of 51,200 bytes. For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.</p> <p>Conditional: You must pass <code>TemplateURL</code> or <code>TemplateBody</code>. If both are passed, only <code>TemplateBody</code> is used.</p>"];
      template_u_r_l: String.t option
        [@ocaml.doc
          "<p>Location of file containing the template body. The URL must point to a template (max size: 460,800 bytes) that is located in an Amazon S3 bucket. For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.</p> <p>Conditional: You must pass <code>TemplateURL</code> or <code>TemplateBody</code>. If both are passed, only <code>TemplateBody</code> is used.</p>"]}
    [@@ocaml.doc "<p>The input for <a>ValidateTemplate</a> action.</p>"]
    let make ?template_body  ?template_u_r_l  () =
      { template_body; template_u_r_l }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.template_u_r_l
              (fun f -> ("template_u_r_l", (String.to_json f)));
           Util.option_map v.template_body
             (fun f -> ("template_body", (String.to_json f)))])
    let parse xml =
      Some
        {
          template_body =
            (Util.option_bind (Xml.member "TemplateBody" xml) String.parse);
          template_u_r_l =
            (Util.option_bind (Xml.member "TemplateURL" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.template_body
               (fun f ->
                  Ezxmlm.make_tag "TemplateBody" ([], (String.to_xml f)))])
           @
           [Util.option_map v.template_u_r_l
              (fun f -> Ezxmlm.make_tag "TemplateURL" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The input for <a>ValidateTemplate</a> action.</p>"]
module ValidateTemplateOutput = ValidateTemplateOutput
type input = ValidateTemplateInput.t
type output = ValidateTemplateOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["ValidateTemplate"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ValidateTemplateInput.to_query req))))) in
  (`POST, uri, (Headers.render (ValidateTemplateInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ValidateTemplateResponse" (snd xml))
        (Xml.member "ValidateTemplateResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ValidateTemplateOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ValidateTemplateOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ValidateTemplateOutput - missing field in body or children: "
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