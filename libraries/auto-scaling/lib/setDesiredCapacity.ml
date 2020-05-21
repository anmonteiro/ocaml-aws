open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SetDesiredCapacityType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      desired_capacity: Integer.t
        [@ocaml.doc
          "<p>The number of EC2 instances that should be running in the Auto Scaling group.</p>"];
      honor_cooldown: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether Amazon EC2 Auto Scaling waits for the cooldown period to complete before initiating a scaling activity to set your Auto Scaling group to its new capacity. By default, Amazon EC2 Auto Scaling does not honor the cooldown period during manual scaling activities.</p>"]}
    let make ~auto_scaling_group_name  ~desired_capacity  ?honor_cooldown  ()
      = { auto_scaling_group_name; desired_capacity; honor_cooldown }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.honor_cooldown
              (fun f -> ("honor_cooldown", (Boolean.to_json f)));
           Some ("desired_capacity", (Integer.to_json v.desired_capacity));
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
          desired_capacity =
            (Xml.required "DesiredCapacity"
               (Util.option_bind (Xml.member "DesiredCapacity" xml)
                  Integer.parse));
          honor_cooldown =
            (Util.option_bind (Xml.member "HonorCooldown" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "DesiredCapacity"
                  ([], (Integer.to_xml v.desired_capacity)))])
           @
           [Util.option_map v.honor_cooldown
              (fun f ->
                 Ezxmlm.make_tag "HonorCooldown" ([], (Boolean.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = SetDesiredCapacityType.t
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
         [("Version", ["2011-01-01"]); ("Action", ["SetDesiredCapacity"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (SetDesiredCapacityType.to_query req))))) in
  (`POST, uri, (Headers.render (SetDesiredCapacityType.to_headers req)), "")
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