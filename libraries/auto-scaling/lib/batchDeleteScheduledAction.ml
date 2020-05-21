open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module BatchDeleteScheduledActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      scheduled_action_names: ScheduledActionNames.t
        [@ocaml.doc
          "<p>The names of the scheduled actions to delete. The maximum number allowed is 50. </p>"]}
    let make ~auto_scaling_group_name  ~scheduled_action_names  () =
      { auto_scaling_group_name; scheduled_action_names }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scheduled_action_names",
                (ScheduledActionNames.to_json v.scheduled_action_names));
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
          scheduled_action_names =
            (Xml.required "ScheduledActionNames"
               (Util.option_bind (Xml.member "ScheduledActionNames" xml)
                  ScheduledActionNames.parse))
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
                   (Ezxmlm.make_tag "ScheduledActionNames"
                      ([], (ScheduledActionNames.to_xml [x]))))
              v.scheduled_action_names))
  end
module BatchDeleteScheduledActionAnswer = BatchDeleteScheduledActionAnswer
type input = BatchDeleteScheduledActionType.t
type output = BatchDeleteScheduledActionAnswer.t
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
         ("Action", ["BatchDeleteScheduledAction"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (BatchDeleteScheduledActionType.to_query req))))) in
  (`POST, uri,
    (Headers.render (BatchDeleteScheduledActionType.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "BatchDeleteScheduledActionResponse" (snd xml))
        (Xml.member "BatchDeleteScheduledActionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp BatchDeleteScheduledActionAnswer.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed BatchDeleteScheduledActionAnswer."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing BatchDeleteScheduledActionAnswer - missing field in body or children: "
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