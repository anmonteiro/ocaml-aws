open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RequestSpotFleetRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      spot_fleet_request_config: SpotFleetRequestConfigData.t
        [@ocaml.doc "<p>The configuration for the Spot Fleet request.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for RequestSpotFleet.</p>"]
    let make ?dry_run  ~spot_fleet_request_config  () =
      { dry_run; spot_fleet_request_config }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("SpotFleetRequestConfig",
                   (SpotFleetRequestConfigData.to_query
                      v.spot_fleet_request_config)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("spot_fleet_request_config",
                (SpotFleetRequestConfigData.to_json
                   v.spot_fleet_request_config));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          spot_fleet_request_config =
            (Xml.required "spotFleetRequestConfig"
               (Util.option_bind (Xml.member "spotFleetRequestConfig" xml)
                  SpotFleetRequestConfigData.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "spotFleetRequestConfig"
                 ([],
                   (SpotFleetRequestConfigData.to_xml
                      v.spot_fleet_request_config)))])
  end[@@ocaml.doc "<p>Contains the parameters for RequestSpotFleet.</p>"]
module RequestSpotFleetResponse = RequestSpotFleetResponse
type input = RequestSpotFleetRequest.t
type output = RequestSpotFleetResponse.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["RequestSpotFleet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RequestSpotFleetRequest.to_query req))))) in
  (`POST, uri, (Headers.render (RequestSpotFleetRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "RequestSpotFleetResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp RequestSpotFleetResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RequestSpotFleetResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RequestSpotFleetResponse - missing field in body or children: "
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