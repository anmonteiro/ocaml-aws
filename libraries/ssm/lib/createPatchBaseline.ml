open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreatePatchBaselineRequest =
  struct
    type t =
      {
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>Defines the operating system the patch baseline applies to. The Default value is WINDOWS.</p>"];
      name: String.t [@ocaml.doc "<p>The name of the patch baseline.</p>"];
      global_filters: PatchFilterGroup.t option
        [@ocaml.doc
          "<p>A set of global filters used to include patches in the baseline.</p>"];
      approval_rules: PatchRuleGroup.t option
        [@ocaml.doc
          "<p>A set of rules used to include patches in the baseline.</p>"];
      approved_patches: PatchIdList.t
        [@ocaml.doc
          "<p>A list of explicitly approved patches for the baseline.</p> <p>For information about accepted formats for lists of approved patches and rejected patches, see <a href=\"https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html\">Package Name Formats for Approved and Rejected Patch Lists</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      approved_patches_compliance_level: PatchComplianceLevel.t option
        [@ocaml.doc
          "<p>Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. The default value is UNSPECIFIED.</p>"];
      approved_patches_enable_non_security: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the list of approved patches includes non-security updates that should be applied to the instances. The default value is 'false'. Applies to Linux instances only.</p>"];
      rejected_patches: PatchIdList.t
        [@ocaml.doc
          "<p>A list of explicitly rejected patches for the baseline.</p> <p>For information about accepted formats for lists of approved patches and rejected patches, see <a href=\"https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html\">Package Name Formats for Approved and Rejected Patch Lists</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      rejected_patches_action: PatchAction.t option
        [@ocaml.doc
          "<p>The action for Patch Manager to take on patches included in the RejectedPackages list.</p> <ul> <li> <p> <b>ALLOW_AS_DEPENDENCY</b>: A package in the Rejected patches list is installed only if it is a dependency of another package. It is considered compliant with the patch baseline, and its status is reported as <i>InstalledOther</i>. This is the default action if no option is specified.</p> </li> <li> <p> <b>BLOCK</b>: Packages in the RejectedPatches list, and packages that include them as dependencies, are not installed under any circumstances. If a package was installed before it was added to the Rejected patches list, it is considered non-compliant with the patch baseline, and its status is reported as <i>InstalledRejected</i>.</p> </li> </ul>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the patch baseline.</p>"];
      sources: PatchSourceList.t
        [@ocaml.doc
          "<p>Information about the patches to use to update the instances, including target operating systems and source repositories. Applies to Linux instances only.</p>"];
      client_token: String.t option
        [@ocaml.doc "<p>User-provided idempotency token.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>Optional metadata that you assign to a resource. Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment. For example, you might want to tag a patch baseline to identify the severity level of patches it specifies and the operating system family it applies to. In this case, you could specify the following key name/value pairs:</p> <ul> <li> <p> <code>Key=PatchSeverity,Value=Critical</code> </p> </li> <li> <p> <code>Key=OS,Value=Windows</code> </p> </li> </ul> <note> <p>To add tags to an existing patch baseline, use the <a>AddTagsToResource</a> action.</p> </note>"]}
    let make ?operating_system  ~name  ?global_filters  ?approval_rules 
      ?(approved_patches= [])  ?approved_patches_compliance_level 
      ?approved_patches_enable_non_security  ?(rejected_patches= []) 
      ?rejected_patches_action  ?description  ?(sources= [])  ?client_token 
      ?(tags= [])  () =
      {
        operating_system;
        name;
        global_filters;
        approval_rules;
        approved_patches;
        approved_patches_compliance_level;
        approved_patches_enable_non_security;
        rejected_patches;
        rejected_patches_action;
        description;
        sources;
        client_token;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Some ("sources", (PatchSourceList.to_json v.sources));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.rejected_patches_action
             (fun f -> ("rejected_patches_action", (PatchAction.to_json f)));
           Some
             ("rejected_patches", (PatchIdList.to_json v.rejected_patches));
           Util.option_map v.approved_patches_enable_non_security
             (fun f ->
                ("approved_patches_enable_non_security", (Boolean.to_json f)));
           Util.option_map v.approved_patches_compliance_level
             (fun f ->
                ("approved_patches_compliance_level",
                  (PatchComplianceLevel.to_json f)));
           Some
             ("approved_patches", (PatchIdList.to_json v.approved_patches));
           Util.option_map v.approval_rules
             (fun f -> ("approval_rules", (PatchRuleGroup.to_json f)));
           Util.option_map v.global_filters
             (fun f -> ("global_filters", (PatchFilterGroup.to_json f)));
           Some ("name", (String.to_json v.name));
           Util.option_map v.operating_system
             (fun f -> ("operating_system", (OperatingSystem.to_json f)))])
    let of_json j =
      {
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json);
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        global_filters =
          (Util.option_map (Json.lookup j "global_filters")
             PatchFilterGroup.of_json);
        approval_rules =
          (Util.option_map (Json.lookup j "approval_rules")
             PatchRuleGroup.of_json);
        approved_patches =
          (PatchIdList.of_json
             (Util.of_option_exn (Json.lookup j "approved_patches")));
        approved_patches_compliance_level =
          (Util.option_map
             (Json.lookup j "approved_patches_compliance_level")
             PatchComplianceLevel.of_json);
        approved_patches_enable_non_security =
          (Util.option_map
             (Json.lookup j "approved_patches_enable_non_security")
             Boolean.of_json);
        rejected_patches =
          (PatchIdList.of_json
             (Util.of_option_exn (Json.lookup j "rejected_patches")));
        rejected_patches_action =
          (Util.option_map (Json.lookup j "rejected_patches_action")
             PatchAction.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        sources =
          (PatchSourceList.of_json
             (Util.of_option_exn (Json.lookup j "sources")));
        client_token =
          (Util.option_map (Json.lookup j "client_token") String.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module CreatePatchBaselineResult = CreatePatchBaselineResult
type input = CreatePatchBaselineRequest.t
type output = CreatePatchBaselineResult.t
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
            (Query.render (CreatePatchBaselineRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CreatePatchBaselineRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (CreatePatchBaselineResult.of_json json)
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