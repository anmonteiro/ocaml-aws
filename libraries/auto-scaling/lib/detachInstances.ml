open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DetachInstancesQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t
        [@ocaml.doc
          "<p>The IDs of the instances. You can specify up to 20 instances.</p>"];
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      should_decrement_desired_capacity: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether the Auto Scaling group decrements the desired capacity value by the number of instances detached.</p>"]}
    let make ?(instance_ids= [])  ~auto_scaling_group_name 
      ~should_decrement_desired_capacity  () =
      {
        instance_ids;
        auto_scaling_group_name;
        should_decrement_desired_capacity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("should_decrement_desired_capacity",
                (Boolean.to_json v.should_decrement_desired_capacity));
           Some
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
                  String.parse));
          should_decrement_desired_capacity =
            (Xml.required "ShouldDecrementDesiredCapacity"
               (Util.option_bind
                  (Xml.member "ShouldDecrementDesiredCapacity" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InstanceIds"
                        ([], (InstanceIds.to_xml [x])))) v.instance_ids))
            @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "ShouldDecrementDesiredCapacity"
                 ([], (Boolean.to_xml v.should_decrement_desired_capacity)))])
  end
module DetachInstancesAnswer = DetachInstancesAnswer
type input = DetachInstancesQuery.t
type output = DetachInstancesAnswer.t
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]); ("Action", ["DetachInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DetachInstancesQuery.to_query req))))) in
  (`POST, uri, (Headers.render (DetachInstancesQuery.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DetachInstancesResponse" (snd xml))
        (Xml.member "DetachInstancesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DetachInstancesAnswer.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DetachInstancesAnswer."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DetachInstancesAnswer - missing field in body or children: "
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