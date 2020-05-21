open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutScheduledUpdateGroupActionType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      scheduled_action_name: String.t
        [@ocaml.doc "<p>The name of this scaling action.</p>"];
      time: DateTime.t option
        [@ocaml.doc "<p>This parameter is no longer used.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time for this action to start, in YYYY-MM-DDThh:mm:ssZ format in UTC/GMT only and in quotes (for example, <code>\"2019-06-01T00:00:00Z\"</code>).</p> <p>If you specify <code>Recurrence</code> and <code>StartTime</code>, Amazon EC2 Auto Scaling performs the action at this time, and then performs the action based on the specified recurrence.</p> <p>If you try to schedule your action in the past, Amazon EC2 Auto Scaling returns an error message.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time for the recurring schedule to end. Amazon EC2 Auto Scaling does not perform the action after this time.</p>"];
      recurrence: String.t option
        [@ocaml.doc
          "<p>The recurring schedule for this action, in Unix cron syntax format. This format consists of five fields separated by white spaces: [Minute] [Hour] [Day_of_Month] [Month_of_Year] [Day_of_Week]. The value must be in quotes (for example, <code>\"30 0 1 1,6,12 *\"</code>). For more information about this format, see <a href=\"http://crontab.org\">Crontab</a>.</p> <p>When <code>StartTime</code> and <code>EndTime</code> are specified with <code>Recurrence</code>, they form the boundaries of when the recurring action starts and stops.</p>"];
      min_size: Integer.t option
        [@ocaml.doc
          "<p>The minimum number of instances in the Auto Scaling group.</p>"];
      max_size: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of instances in the Auto Scaling group.</p>"];
      desired_capacity: Integer.t option
        [@ocaml.doc
          "<p>The number of EC2 instances that should be running in the Auto Scaling group.</p>"]}
    let make ~auto_scaling_group_name  ~scheduled_action_name  ?time 
      ?start_time  ?end_time  ?recurrence  ?min_size  ?max_size 
      ?desired_capacity  () =
      {
        auto_scaling_group_name;
        scheduled_action_name;
        time;
        start_time;
        end_time;
        recurrence;
        min_size;
        max_size;
        desired_capacity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.desired_capacity
              (fun f -> ("desired_capacity", (Integer.to_json f)));
           Util.option_map v.max_size
             (fun f -> ("max_size", (Integer.to_json f)));
           Util.option_map v.min_size
             (fun f -> ("min_size", (Integer.to_json f)));
           Util.option_map v.recurrence
             (fun f -> ("recurrence", (String.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.time (fun f -> ("time", (DateTime.to_json f)));
           Some
             ("scheduled_action_name",
               (String.to_json v.scheduled_action_name));
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
          scheduled_action_name =
            (Xml.required "ScheduledActionName"
               (Util.option_bind (Xml.member "ScheduledActionName" xml)
                  String.parse));
          time = (Util.option_bind (Xml.member "Time" xml) DateTime.parse);
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse);
          recurrence =
            (Util.option_bind (Xml.member "Recurrence" xml) String.parse);
          min_size =
            (Util.option_bind (Xml.member "MinSize" xml) Integer.parse);
          max_size =
            (Util.option_bind (Xml.member "MaxSize" xml) Integer.parse);
          desired_capacity =
            (Util.option_bind (Xml.member "DesiredCapacity" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some
                      (Ezxmlm.make_tag "AutoScalingGroupName"
                         ([], (String.to_xml v.auto_scaling_group_name)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "ScheduledActionName"
                        ([], (String.to_xml v.scheduled_action_name)))])
                 @
                 [Util.option_map v.time
                    (fun f ->
                       Ezxmlm.make_tag "Time" ([], (DateTime.to_xml f)))])
                @
                [Util.option_map v.start_time
                   (fun f ->
                      Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
               @
               [Util.option_map v.end_time
                  (fun f ->
                     Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.recurrence
                 (fun f ->
                    Ezxmlm.make_tag "Recurrence" ([], (String.to_xml f)))])
             @
             [Util.option_map v.min_size
                (fun f -> Ezxmlm.make_tag "MinSize" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.max_size
               (fun f -> Ezxmlm.make_tag "MaxSize" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.desired_capacity
              (fun f ->
                 Ezxmlm.make_tag "DesiredCapacity" ([], (Integer.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutScheduledUpdateGroupActionType.t
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
         ("Action", ["PutScheduledUpdateGroupAction"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutScheduledUpdateGroupActionType.to_query req))))) in
  (`POST, uri,
    (Headers.render (PutScheduledUpdateGroupActionType.to_headers req)), "")
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