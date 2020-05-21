open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module TerminateInstanceInAutoScalingGroupType =
  struct
    type t =
      {
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      should_decrement_desired_capacity: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether terminating the instance also decrements the size of the Auto Scaling group.</p>"]}
    let make ~instance_id  ~should_decrement_desired_capacity  () =
      { instance_id; should_decrement_desired_capacity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("should_decrement_desired_capacity",
                (Boolean.to_json v.should_decrement_desired_capacity));
           Some ("instance_id", (String.to_json v.instance_id))])
    let parse xml =
      Some
        {
          instance_id =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml) String.parse));
          should_decrement_desired_capacity =
            (Xml.required "ShouldDecrementDesiredCapacity"
               (Util.option_bind
                  (Xml.member "ShouldDecrementDesiredCapacity" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "InstanceId"
                  ([], (String.to_xml v.instance_id)))])
           @
           [Some
              (Ezxmlm.make_tag "ShouldDecrementDesiredCapacity"
                 ([], (Boolean.to_xml v.should_decrement_desired_capacity)))])
  end
module ActivityType = ActivityType
type input = TerminateInstanceInAutoScalingGroupType.t
type output = ActivityType.t
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
         ("Action", ["TerminateInstanceInAutoScalingGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (TerminateInstanceInAutoScalingGroupType.to_query req))))) in
  (`POST, uri,
    (Headers.render (TerminateInstanceInAutoScalingGroupType.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "TerminateInstanceInAutoScalingGroupResponse" (snd xml))
        (Xml.member "TerminateInstanceInAutoScalingGroupResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ActivityType.parse)
          (BadResponse
             { body; message = "Could not find well formed ActivityType." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ActivityType - missing field in body or children: "
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