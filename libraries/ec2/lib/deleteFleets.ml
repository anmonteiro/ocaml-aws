open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteFleetsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      fleet_ids: FleetIdSet.t
        [@ocaml.doc "<p>The IDs of the EC2 Fleets.</p>"];
      terminate_instances: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether to terminate instances for an EC2 Fleet if it is deleted successfully.</p>"]}
    let make ?dry_run  ~fleet_ids  ~terminate_instances  () =
      { dry_run; fleet_ids; terminate_instances }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TerminateInstances",
                   (Boolean.to_query v.terminate_instances)));
           Some (Query.Pair ("FleetId", (FleetIdSet.to_query v.fleet_ids)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("terminate_instances",
                (Boolean.to_json v.terminate_instances));
           Some ("fleet_ids", (FleetIdSet.to_json v.fleet_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          fleet_ids =
            (Xml.required "FleetId"
               (Util.option_bind (Xml.member "FleetId" xml) FleetIdSet.parse));
          terminate_instances =
            (Xml.required "TerminateInstances"
               (Util.option_bind (Xml.member "TerminateInstances" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "FleetId" ([], (FleetIdSet.to_xml [x]))))
               v.fleet_ids))
           @
           [Some
              (Ezxmlm.make_tag "TerminateInstances"
                 ([], (Boolean.to_xml v.terminate_instances)))])
  end
module DeleteFleetsResult = DeleteFleetsResult
type input = DeleteFleetsRequest.t
type output = DeleteFleetsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DeleteFleets"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteFleetsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteFleetsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DeleteFleetsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteFleetsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DeleteFleetsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteFleetsResult - missing field in body or children: "
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