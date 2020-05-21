open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeLifecycleHooksType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      lifecycle_hook_names: LifecycleHookNames.t
        [@ocaml.doc
          "<p>The names of one or more lifecycle hooks. If you omit this parameter, all lifecycle hooks are described.</p>"]}
    let make ~auto_scaling_group_name  ?(lifecycle_hook_names= [])  () =
      { auto_scaling_group_name; lifecycle_hook_names }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("lifecycle_hook_names",
                (LifecycleHookNames.to_json v.lifecycle_hook_names));
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
          lifecycle_hook_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "LifecycleHookNames" xml)
                  LifecycleHookNames.parse))
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
                   (Ezxmlm.make_tag "LifecycleHookNames"
                      ([], (LifecycleHookNames.to_xml [x]))))
              v.lifecycle_hook_names))
  end
module DescribeLifecycleHooksAnswer = DescribeLifecycleHooksAnswer
type input = DescribeLifecycleHooksType.t
type output = DescribeLifecycleHooksAnswer.t
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
         ("Action", ["DescribeLifecycleHooks"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeLifecycleHooksType.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeLifecycleHooksType.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeLifecycleHooksResponse" (snd xml))
        (Xml.member "DescribeLifecycleHooksResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeLifecycleHooksAnswer.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeLifecycleHooksAnswer."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeLifecycleHooksAnswer - missing field in body or children: "
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