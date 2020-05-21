open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyLaunchTemplateRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p> <p>Constraint: Maximum 128 ASCII characters.</p>"];
      launch_template_id: String.t option
        [@ocaml.doc
          "<p>The ID of the launch template. You must specify either the launch template ID or launch template name in the request.</p>"];
      launch_template_name: String.t option
        [@ocaml.doc
          "<p>The name of the launch template. You must specify either the launch template ID or launch template name in the request.</p>"];
      default_version: String.t option
        [@ocaml.doc
          "<p>The version number of the launch template to set as the default version.</p>"]}
    let make ?dry_run  ?client_token  ?launch_template_id 
      ?launch_template_name  ?default_version  () =
      {
        dry_run;
        client_token;
        launch_template_id;
        launch_template_name;
        default_version
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.default_version
              (fun f -> Query.Pair ("SetDefaultVersion", (String.to_query f)));
           Util.option_map v.launch_template_name
             (fun f -> Query.Pair ("LaunchTemplateName", (String.to_query f)));
           Util.option_map v.launch_template_id
             (fun f -> Query.Pair ("LaunchTemplateId", (String.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_version
              (fun f -> ("default_version", (String.to_json f)));
           Util.option_map v.launch_template_name
             (fun f -> ("launch_template_name", (String.to_json f)));
           Util.option_map v.launch_template_id
             (fun f -> ("launch_template_id", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          launch_template_id =
            (Util.option_bind (Xml.member "LaunchTemplateId" xml)
               String.parse);
          launch_template_name =
            (Util.option_bind (Xml.member "LaunchTemplateName" xml)
               String.parse);
          default_version =
            (Util.option_bind (Xml.member "SetDefaultVersion" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.dry_run
                  (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.client_token
                 (fun f ->
                    Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
             @
             [Util.option_map v.launch_template_id
                (fun f ->
                   Ezxmlm.make_tag "LaunchTemplateId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.launch_template_name
               (fun f ->
                  Ezxmlm.make_tag "LaunchTemplateName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.default_version
              (fun f ->
                 Ezxmlm.make_tag "SetDefaultVersion" ([], (String.to_xml f)))])
  end
module ModifyLaunchTemplateResult = ModifyLaunchTemplateResult
type input = ModifyLaunchTemplateRequest.t
type output = ModifyLaunchTemplateResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ModifyLaunchTemplate"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyLaunchTemplateRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyLaunchTemplateRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyLaunchTemplateResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyLaunchTemplateResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyLaunchTemplateResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyLaunchTemplateResult - missing field in body or children: "
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