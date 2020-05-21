open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RunScheduledInstancesRequest =
  struct
    type t =
      {
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that ensures the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_count: Integer.t option
        [@ocaml.doc "<p>The number of instances.</p> <p>Default: 1</p>"];
      launch_specification: ScheduledInstancesLaunchSpecification.t
        [@ocaml.doc
          "<p>The launch specification. You must match the instance type, Availability Zone, network, and platform of the schedule that you purchased.</p>"];
      scheduled_instance_id: String.t
        [@ocaml.doc "<p>The Scheduled Instance ID.</p>"]}[@@ocaml.doc
                                                           "<p>Contains the parameters for RunScheduledInstances.</p>"]
    let make ?client_token  ?dry_run  ?instance_count  ~launch_specification 
      ~scheduled_instance_id  () =
      {
        client_token;
        dry_run;
        instance_count;
        launch_specification;
        scheduled_instance_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("ScheduledInstanceId",
                   (String.to_query v.scheduled_instance_id)));
           Some
             (Query.Pair
                ("LaunchSpecification",
                  (ScheduledInstancesLaunchSpecification.to_query
                     v.launch_specification)));
           Util.option_map v.instance_count
             (fun f -> Query.Pair ("InstanceCount", (Integer.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scheduled_instance_id",
                (String.to_json v.scheduled_instance_id));
           Some
             ("launch_specification",
               (ScheduledInstancesLaunchSpecification.to_json
                  v.launch_specification));
           Util.option_map v.instance_count
             (fun f -> ("instance_count", (Integer.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          instance_count =
            (Util.option_bind (Xml.member "InstanceCount" xml) Integer.parse);
          launch_specification =
            (Xml.required "LaunchSpecification"
               (Util.option_bind (Xml.member "LaunchSpecification" xml)
                  ScheduledInstancesLaunchSpecification.parse));
          scheduled_instance_id =
            (Xml.required "ScheduledInstanceId"
               (Util.option_bind (Xml.member "ScheduledInstanceId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.client_token
                  (fun f ->
                     Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.instance_count
                (fun f ->
                   Ezxmlm.make_tag "InstanceCount" ([], (Integer.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "LaunchSpecification"
                  ([],
                    (ScheduledInstancesLaunchSpecification.to_xml
                       v.launch_specification)))])
           @
           [Some
              (Ezxmlm.make_tag "ScheduledInstanceId"
                 ([], (String.to_xml v.scheduled_instance_id)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for RunScheduledInstances.</p>"]
module RunScheduledInstancesResult = RunScheduledInstancesResult
type input = RunScheduledInstancesRequest.t
type output = RunScheduledInstancesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["RunScheduledInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RunScheduledInstancesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (RunScheduledInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "RunScheduledInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RunScheduledInstancesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RunScheduledInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RunScheduledInstancesResult - missing field in body or children: "
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