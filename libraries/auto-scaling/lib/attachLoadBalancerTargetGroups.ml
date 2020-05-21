open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AttachLoadBalancerTargetGroupsType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      target_group_a_r_ns: TargetGroupARNs.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARN) of the target groups. You can specify up to 10 target groups.</p>"]}
    let make ~auto_scaling_group_name  ~target_group_a_r_ns  () =
      { auto_scaling_group_name; target_group_a_r_ns }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("target_group_a_r_ns",
                (TargetGroupARNs.to_json v.target_group_a_r_ns));
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
          target_group_a_r_ns =
            (Xml.required "TargetGroupARNs"
               (Util.option_bind (Xml.member "TargetGroupARNs" xml)
                  TargetGroupARNs.parse))
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
                   (Ezxmlm.make_tag "TargetGroupARNs"
                      ([], (TargetGroupARNs.to_xml [x]))))
              v.target_group_a_r_ns))
  end
module Output = Aws.BaseTypes.Unit
type input = AttachLoadBalancerTargetGroupsType.t
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
         [("Version", ["2011-01-01"]);
         ("Action", ["AttachLoadBalancerTargetGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (AttachLoadBalancerTargetGroupsType.to_query req))))) in
  (`POST, uri,
    (Headers.render (AttachLoadBalancerTargetGroupsType.to_headers req)), "")
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