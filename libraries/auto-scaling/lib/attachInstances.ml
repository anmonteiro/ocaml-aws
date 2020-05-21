open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AttachInstancesQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t
        [@ocaml.doc
          "<p>The IDs of the instances. You can specify up to 20 instances.</p>"];
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"]}
    let make ?(instance_ids= [])  ~auto_scaling_group_name  () =
      { instance_ids; auto_scaling_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("auto_scaling_group_name",
                (String.to_json v.auto_scaling_group_name));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let parse xml =
      Some
        {
          instance_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "InstanceIds"
                       ([], (InstanceIds.to_xml [x])))) v.instance_ids))
           @
           [Some
              (Ezxmlm.make_tag "AutoScalingGroupName"
                 ([], (String.to_xml v.auto_scaling_group_name)))])
  end
module Output = Aws.BaseTypes.Unit
type input = AttachInstancesQuery.t
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
         [("Version", ["2011-01-01"]); ("Action", ["AttachInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AttachInstancesQuery.to_query req))))) in
  (`POST, uri, (Headers.render (AttachInstancesQuery.to_headers req)), "")
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