(** "<p>Updates an existing health check. Note that some values can't be updated. </p> <p>For more information about updating health checks, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/health-checks-creating-deleting.html\">Creating, Updating, and Deleting Health Checks</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateHealthCheckRequest :
sig
  type t =
    {
    health_check_id: String.t ;
    health_check_version: Long.t option ;
    i_p_address: String.t option ;
    port: Integer.t option ;
    resource_path: String.t option ;
    fully_qualified_domain_name: String.t option ;
    search_string: String.t option ;
    failure_threshold: Integer.t option ;
    inverted: Boolean.t option ;
    disabled: Boolean.t option ;
    health_threshold: Integer.t option ;
    child_health_checks: ChildHealthCheckList.t ;
    enable_s_n_i: Boolean.t option ;
    regions: HealthCheckRegionList.t ;
    alarm_identifier: AlarmIdentifier.t option ;
    insufficient_data_health_status: InsufficientDataHealthStatus.t option ;
    reset_elements: ResettableElementNameList.t }[@@ocaml.doc
                                                   "<p>A complex type that contains information about a request to update a health check.</p>"]
  val make :
    health_check_id:String.t ->
      ?health_check_version:Long.t ->
        ?i_p_address:String.t ->
          ?port:Integer.t ->
            ?resource_path:String.t ->
              ?fully_qualified_domain_name:String.t ->
                ?search_string:String.t ->
                  ?failure_threshold:Integer.t ->
                    ?inverted:Boolean.t ->
                      ?disabled:Boolean.t ->
                        ?health_threshold:Integer.t ->
                          ?child_health_checks:ChildHealthCheckList.t ->
                            ?enable_s_n_i:Boolean.t ->
                              ?regions:HealthCheckRegionList.t ->
                                ?alarm_identifier:AlarmIdentifier.t ->
                                  ?insufficient_data_health_status:InsufficientDataHealthStatus.t
                                    ->
                                    ?reset_elements:ResettableElementNameList.t
                                      -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UpdateHealthCheckResponse = UpdateHealthCheckResponse
type input = UpdateHealthCheckRequest.t
type output = UpdateHealthCheckResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error