open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CancelSpotFleetRequestsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      spot_fleet_request_ids: ValueStringList.t
        [@ocaml.doc "<p>The IDs of the Spot Fleet requests.</p>"];
      terminate_instances: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether to terminate instances for a Spot Fleet request if it is canceled successfully.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for CancelSpotFleetRequests.</p>"]
    let make ?dry_run  ~spot_fleet_request_ids  ~terminate_instances  () =
      { dry_run; spot_fleet_request_ids; terminate_instances }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TerminateInstances",
                   (Boolean.to_query v.terminate_instances)));
           Some
             (Query.Pair
                ("SpotFleetRequestId",
                  (ValueStringList.to_query v.spot_fleet_request_ids)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("terminate_instances",
                (Boolean.to_json v.terminate_instances));
           Some
             ("spot_fleet_request_ids",
               (ValueStringList.to_json v.spot_fleet_request_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          spot_fleet_request_ids =
            (Xml.required "spotFleetRequestId"
               (Util.option_bind (Xml.member "spotFleetRequestId" xml)
                  ValueStringList.parse));
          terminate_instances =
            (Xml.required "terminateInstances"
               (Util.option_bind (Xml.member "terminateInstances" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "spotFleetRequestId"
                       ([], (ValueStringList.to_xml [x]))))
               v.spot_fleet_request_ids))
           @
           [Some
              (Ezxmlm.make_tag "terminateInstances"
                 ([], (Boolean.to_xml v.terminate_instances)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for CancelSpotFleetRequests.</p>"]
module CancelSpotFleetRequestsResponse = CancelSpotFleetRequestsResponse
type input = CancelSpotFleetRequestsRequest.t
type output = CancelSpotFleetRequestsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["CancelSpotFleetRequests"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CancelSpotFleetRequestsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CancelSpotFleetRequestsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CancelSpotFleetRequestsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CancelSpotFleetRequestsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CancelSpotFleetRequestsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CancelSpotFleetRequestsResponse - missing field in body or children: "
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