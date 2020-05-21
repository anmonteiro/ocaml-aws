open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module BatchPutScheduledUpdateGroupActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      scheduled_update_group_actions: ScheduledUpdateGroupActionRequests.t
        [@ocaml.doc
          "<p>One or more scheduled actions. The maximum number allowed is 50.</p>"]}
    let make ~auto_scaling_group_name  ~scheduled_update_group_actions  () =
      { auto_scaling_group_name; scheduled_update_group_actions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scheduled_update_group_actions",
                (ScheduledUpdateGroupActionRequests.to_json
                   v.scheduled_update_group_actions));
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
          scheduled_update_group_actions =
            (Xml.required "ScheduledUpdateGroupActions"
               (Util.option_bind
                  (Xml.member "ScheduledUpdateGroupActions" xml)
                  ScheduledUpdateGroupActionRequests.parse))
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
                   (Ezxmlm.make_tag "ScheduledUpdateGroupActions"
                      ([], (ScheduledUpdateGroupActionRequests.to_xml [x]))))
              v.scheduled_update_group_actions))
  end
module BatchPutScheduledUpdateGroupActionAnswer =
  BatchPutScheduledUpdateGroupActionAnswer
type input = BatchPutScheduledUpdateGroupActionType.t
type output = BatchPutScheduledUpdateGroupActionAnswer.t
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
         ("Action", ["BatchPutScheduledUpdateGroupAction"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (BatchPutScheduledUpdateGroupActionType.to_query req))))) in
  (`POST, uri,
    (Headers.render (BatchPutScheduledUpdateGroupActionType.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "BatchPutScheduledUpdateGroupActionResponse" (snd xml))
        (Xml.member "BatchPutScheduledUpdateGroupActionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             BatchPutScheduledUpdateGroupActionAnswer.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed BatchPutScheduledUpdateGroupActionAnswer."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing BatchPutScheduledUpdateGroupActionAnswer - missing field in body or children: "
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