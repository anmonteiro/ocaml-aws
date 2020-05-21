open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SetInstanceHealthQuery =
  struct
    type t =
      {
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      health_status: String.t
        [@ocaml.doc
          "<p>The health status of the instance. Set to <code>Healthy</code> to have the instance remain in service. Set to <code>Unhealthy</code> to have the instance be out of service. Amazon EC2 Auto Scaling terminates and replaces the unhealthy instance.</p>"];
      should_respect_grace_period: Boolean.t option
        [@ocaml.doc
          "<p>If the Auto Scaling group of the specified instance has a <code>HealthCheckGracePeriod</code> specified for the group, by default, this call respects the grace period. Set this to <code>False</code>, to have the call not respect the grace period associated with the group.</p> <p>For more information about the health check grace period, see <a>CreateAutoScalingGroup</a>.</p>"]}
    let make ~instance_id  ~health_status  ?should_respect_grace_period  () =
      { instance_id; health_status; should_respect_grace_period }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.should_respect_grace_period
              (fun f -> ("should_respect_grace_period", (Boolean.to_json f)));
           Some ("health_status", (String.to_json v.health_status));
           Some ("instance_id", (String.to_json v.instance_id))])
    let parse xml =
      Some
        {
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          health_status =
            (Xml.required "HealthStatus"
               (Util.option_bind (Xml.member "HealthStatus" xml) String.parse));
          should_respect_grace_period =
            (Util.option_bind (Xml.member "ShouldRespectGracePeriod" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "InstanceId"
                   ([], (String.to_xml v.instance_id)))])
            @
            [Some
               (Ezxmlm.make_tag "HealthStatus"
                  ([], (String.to_xml v.health_status)))])
           @
           [Util.option_map v.should_respect_grace_period
              (fun f ->
                 Ezxmlm.make_tag "ShouldRespectGracePeriod"
                   ([], (Boolean.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = SetInstanceHealthQuery.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]); ("Action", ["SetInstanceHealth"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (SetInstanceHealthQuery.to_query req))))) in
  (`POST, uri, (Headers.render (SetInstanceHealthQuery.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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