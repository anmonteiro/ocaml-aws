open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StopInstancesRequest =
  struct
    type t =
      {
      instance_ids: InstanceIdStringList.t
        [@ocaml.doc "<p>The IDs of the instances.</p>"];
      hibernate: Boolean.t option
        [@ocaml.doc
          "<p>Hibernates the instance if the instance was enabled for hibernation at launch. If the instance cannot hibernate successfully, a normal shutdown occurs. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html\">Hibernate Your Instance</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p> Default: <code>false</code> </p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      force: Boolean.t option
        [@ocaml.doc
          "<p>Forces the instances to stop. The instances do not have an opportunity to flush file system caches or file system metadata. If you use this option, you must perform file system check and repair procedures. This option is not recommended for Windows instances.</p> <p>Default: <code>false</code> </p>"]}
    let make ~instance_ids  ?hibernate  ?dry_run  ?force  () =
      { instance_ids; hibernate; dry_run; force }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.force
              (fun f -> Query.Pair ("Force", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.hibernate
             (fun f -> Query.Pair ("Hibernate", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("InstanceId",
                  (InstanceIdStringList.to_query v.instance_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.hibernate
             (fun f -> ("hibernate", (Boolean.to_json f)));
           Some
             ("instance_ids", (InstanceIdStringList.to_json v.instance_ids))])
    let parse xml =
      Some
        {
          instance_ids =
            (Xml.required "InstanceId"
               (Util.option_bind (Xml.member "InstanceId" xml)
                  InstanceIdStringList.parse));
          hibernate =
            (Util.option_bind (Xml.member "Hibernate" xml) Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          force = (Util.option_bind (Xml.member "force" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "InstanceId"
                         ([], (InstanceIdStringList.to_xml [x]))))
                 v.instance_ids))
             @
             [Util.option_map v.hibernate
                (fun f ->
                   Ezxmlm.make_tag "Hibernate" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.force
              (fun f -> Ezxmlm.make_tag "force" ([], (Boolean.to_xml f)))])
  end
module StopInstancesResult = StopInstancesResult
type input = StopInstancesRequest.t
type output = StopInstancesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["StopInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (StopInstancesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (StopInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "StopInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp StopInstancesResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed StopInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing StopInstancesResult - missing field in body or children: "
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