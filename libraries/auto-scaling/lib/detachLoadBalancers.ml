open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DetachLoadBalancersType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      load_balancer_names: LoadBalancerNames.t
        [@ocaml.doc
          "<p>The names of the load balancers. You can specify up to 10 load balancers.</p>"]}
    let make ~auto_scaling_group_name  ~load_balancer_names  () =
      { auto_scaling_group_name; load_balancer_names }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("load_balancer_names",
                (LoadBalancerNames.to_json v.load_balancer_names));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          load_balancer_names =
            (Xml.required "LoadBalancerNames"
               (Util.option_bind (Xml.member "LoadBalancerNames" xml)
                  LoadBalancerNames.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LoadBalancerNames"
                      ([], (LoadBalancerNames.to_xml [x]))))
              v.load_balancer_names))
  end
module Output = Aws.BaseTypes.Unit
type input = DetachLoadBalancersType.t
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
         [("Version", ["2011-01-01"]); ("Action", ["DetachLoadBalancers"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DetachLoadBalancersType.to_query req))))) in
  (`POST, uri, (Headers.render (DetachLoadBalancersType.to_headers req)), "")
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