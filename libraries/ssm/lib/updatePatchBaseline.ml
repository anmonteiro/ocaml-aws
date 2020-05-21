open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdatePatchBaselineRequest =
  struct
    type t =
      {
      baseline_id: String.t
        [@ocaml.doc "<p>The ID of the patch baseline to update.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the patch baseline.</p>"];
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
          "<p>Assigns a new compliance severity level to an existing patch baseline.</p>"];
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
      replace: Boolean.t option
        [@ocaml.doc
          "<p>If True, then all fields that are required by the CreatePatchBaseline action are also required for this API request. Optional fields that are not specified are set to null.</p>"]}
    let make ~baseline_id  ?name  ?global_filters  ?approval_rules 
      ?(approved_patches= [])  ?approved_patches_compliance_level 
      ?approved_patches_enable_non_security  ?(rejected_patches= []) 
      ?rejected_patches_action  ?description  ?(sources= [])  ?replace  () =
      {
        baseline_id;
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
        replace
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replace
              (fun f -> ("replace", (Boolean.to_json f)));
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
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Some ("baseline_id", (String.to_json v.baseline_id))])
    let of_json j =
      {
        baseline_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "baseline_id")));
        name = (Util.option_map (Json.lookup j "name") String.of_json);
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
        replace = (Util.option_map (Json.lookup j "replace") Boolean.of_json)
      }
  end
module UpdatePatchBaselineResult = UpdatePatchBaselineResult
type input = UpdatePatchBaselineRequest.t
type output = UpdatePatchBaselineResult.t
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
            (Query.render (UpdatePatchBaselineRequest.to_query req)))) in
  (`POST, uri, (Headers.render (UpdatePatchBaselineRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdatePatchBaselineResult.of_json json)
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