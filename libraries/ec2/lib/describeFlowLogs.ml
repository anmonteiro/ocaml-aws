open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeFlowLogsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      filter: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>deliver-log-status</code> - The status of the logs delivery (<code>SUCCESS</code> | <code>FAILED</code>).</p> </li> <li> <p> <code>log-destination-type</code> - The type of destination to which the flow log publishes data. Possible destination types include <code>cloud-watch-logs</code> and <code>S3</code>.</p> </li> <li> <p> <code>flow-log-id</code> - The ID of the flow log.</p> </li> <li> <p> <code>log-group-name</code> - The name of the log group.</p> </li> <li> <p> <code>resource-id</code> - The ID of the VPC, subnet, or network interface.</p> </li> <li> <p> <code>traffic-type</code> - The type of traffic (<code>ACCEPT</code> | <code>REJECT</code> | <code>ALL</code>).</p> </li> </ul>"];
      flow_log_ids: ValueStringList.t
        [@ocaml.doc
          "<p>One or more flow log IDs.</p> <p>Constraint: Maximum of 1000 flow log IDs.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return with a single call. To retrieve the remaining results, make another call with the returned <code>nextToken</code> value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next page of results.</p>"]}
    let make ?dry_run  ?(filter= [])  ?(flow_log_ids= [])  ?max_results 
      ?next_token  () =
      { dry_run; filter; flow_log_ids; max_results; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some
             (Query.Pair
                ("FlowLogId", (ValueStringList.to_query v.flow_log_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filter)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("flow_log_ids", (ValueStringList.to_json v.flow_log_ids));
           Some ("filter", (FilterList.to_json v.filter));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          filter =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          flow_log_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "FlowLogId" xml)
                  ValueStringList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.dry_run
                  (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filter))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "FlowLogId"
                        ([], (ValueStringList.to_xml [x])))) v.flow_log_ids))
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeFlowLogsResult = DescribeFlowLogsResult
type input = DescribeFlowLogsRequest.t
type output = DescribeFlowLogsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeFlowLogs"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeFlowLogsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeFlowLogsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeFlowLogsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeFlowLogsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeFlowLogsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeFlowLogsResult - missing field in body or children: "
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