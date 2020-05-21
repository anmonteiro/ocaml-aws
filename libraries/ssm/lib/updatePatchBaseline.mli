(** "<p>Modifies an existing patch baseline. Fields not specified in the request are left unchanged.</p> <note> <p>For information about valid key and value pairs in <code>PatchFilters</code> for each supported operating system type, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/APIReference/API_PatchFilter.html\">PatchFilter</a>.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdatePatchBaselineRequest :
sig
  type t =
    {
    baseline_id: String.t ;
    name: String.t option ;
    global_filters: PatchFilterGroup.t option ;
    approval_rules: PatchRuleGroup.t option ;
    approved_patches: PatchIdList.t ;
    approved_patches_compliance_level: PatchComplianceLevel.t option ;
    approved_patches_enable_non_security: Boolean.t option ;
    rejected_patches: PatchIdList.t ;
    rejected_patches_action: PatchAction.t option ;
    description: String.t option ;
    sources: PatchSourceList.t ;
    replace: Boolean.t option }
  val make :
    baseline_id:String.t ->
      ?name:String.t ->
        ?global_filters:PatchFilterGroup.t ->
          ?approval_rules:PatchRuleGroup.t ->
            ?approved_patches:PatchIdList.t ->
              ?approved_patches_compliance_level:PatchComplianceLevel.t ->
                ?approved_patches_enable_non_security:Boolean.t ->
                  ?rejected_patches:PatchIdList.t ->
                    ?rejected_patches_action:PatchAction.t ->
                      ?description:String.t ->
                        ?sources:PatchSourceList.t ->
                          ?replace:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdatePatchBaselineResult = UpdatePatchBaselineResult
type input = UpdatePatchBaselineRequest.t
type output = UpdatePatchBaselineResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error