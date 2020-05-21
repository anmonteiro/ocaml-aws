open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeSpotFleetInstancesRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. Specify a value between 1 and 1000. The default value is 1000. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next set of results.</p>"];
      spot_fleet_request_id: String.t
        [@ocaml.doc "<p>The ID of the Spot Fleet request.</p>"]}[@@ocaml.doc
                                                                  "<p>Contains the parameters for DescribeSpotFleetInstances.</p>"]
    let make ?dry_run  ?max_results  ?next_token  ~spot_fleet_request_id  ()
      = { dry_run; max_results; next_token; spot_fleet_request_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("SpotFleetRequestId",
                   (String.to_query v.spot_fleet_request_id)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("spot_fleet_request_id",
                (String.to_json v.spot_fleet_request_id));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          max_results =
            (Util.option_bind (Xml.member "maxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse);
          spot_fleet_request_id =
            (Xml.required "spotFleetRequestId"
               (Util.option_bind (Xml.member "spotFleetRequestId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.max_results
                (fun f ->
                   Ezxmlm.make_tag "maxResults" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "spotFleetRequestId"
                 ([], (String.to_xml v.spot_fleet_request_id)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeSpotFleetInstances.</p>"]
module DescribeSpotFleetInstancesResponse =
  DescribeSpotFleetInstancesResponse
type input = DescribeSpotFleetInstancesRequest.t
type output = DescribeSpotFleetInstancesResponse.t
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
         ("Action", ["DescribeSpotFleetInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeSpotFleetInstancesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeSpotFleetInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeSpotFleetInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeSpotFleetInstancesResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeSpotFleetInstancesResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeSpotFleetInstancesResponse - missing field in body or children: "
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