open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ReportInstanceStatusRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc
          "<p>Descriptive text about the health state of your instance.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The time at which the reported instance health state ended.</p>"];
      instances: InstanceIdStringList.t [@ocaml.doc "<p>The instances.</p>"];
      reason_codes: ReasonCodesList.t
        [@ocaml.doc
          "<p>The reason codes that describe the health state of your instance.</p> <ul> <li> <p> <code>instance-stuck-in-state</code>: My instance is stuck in a state.</p> </li> <li> <p> <code>unresponsive</code>: My instance is unresponsive.</p> </li> <li> <p> <code>not-accepting-credentials</code>: My instance is not accepting my credentials.</p> </li> <li> <p> <code>password-not-available</code>: A password is not available for my instance.</p> </li> <li> <p> <code>performance-network</code>: My instance is experiencing performance problems that I believe are network related.</p> </li> <li> <p> <code>performance-instance-store</code>: My instance is experiencing performance problems that I believe are related to the instance stores.</p> </li> <li> <p> <code>performance-ebs-volume</code>: My instance is experiencing performance problems that I believe are related to an EBS volume.</p> </li> <li> <p> <code>performance-other</code>: My instance is experiencing performance problems.</p> </li> <li> <p> <code>other</code>: [explain using the description parameter]</p> </li> </ul>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The time at which the reported instance health state began.</p>"];
      status: ReportStatusType.t
        [@ocaml.doc "<p>The status of all instances listed.</p>"]}
    let make ?description  ?dry_run  ?end_time  ~instances  ~reason_codes 
      ?start_time  ~status  () =
      {
        description;
        dry_run;
        end_time;
        instances;
        reason_codes;
        start_time;
        status
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair ("Status", (ReportStatusType.to_query v.status)));
           Util.option_map v.start_time
             (fun f -> Query.Pair ("StartTime", (DateTime.to_query f)));
           Some
             (Query.Pair
                ("ReasonCode", (ReasonCodesList.to_query v.reason_codes)));
           Some
             (Query.Pair
                ("InstanceId", (InstanceIdStringList.to_query v.instances)));
           Util.option_map v.end_time
             (fun f -> Query.Pair ("EndTime", (DateTime.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("status", (ReportStatusType.to_json v.status));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Some ("reason_codes", (ReasonCodesList.to_json v.reason_codes));
           Some ("instances", (InstanceIdStringList.to_json v.instances));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "description" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          end_time =
            (Util.option_bind (Xml.member "endTime" xml) DateTime.parse);
          instances =
            (Xml.required "instanceId"
               (Util.option_bind (Xml.member "instanceId" xml)
                  InstanceIdStringList.parse));
          reason_codes =
            (Xml.required "reasonCode"
               (Util.option_bind (Xml.member "reasonCode" xml)
                  ReasonCodesList.parse));
          start_time =
            (Util.option_bind (Xml.member "startTime" xml) DateTime.parse);
          status =
            (Xml.required "status"
               (Util.option_bind (Xml.member "status" xml)
                  ReportStatusType.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.description
                    (fun f ->
                       Ezxmlm.make_tag "description" ([], (String.to_xml f)))])
                @
                [Util.option_map v.dry_run
                   (fun f ->
                      Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.end_time
                  (fun f ->
                     Ezxmlm.make_tag "endTime" ([], (DateTime.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "instanceId"
                         ([], (InstanceIdStringList.to_xml [x]))))
                 v.instances))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "reasonCode"
                        ([], (ReasonCodesList.to_xml [x])))) v.reason_codes))
            @
            [Util.option_map v.start_time
               (fun f ->
                  Ezxmlm.make_tag "startTime" ([], (DateTime.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "status"
                 ([], (ReportStatusType.to_xml v.status)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ReportInstanceStatusRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ReportInstanceStatus"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ReportInstanceStatusRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ReportInstanceStatusRequest.to_headers req)),
    "")
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