open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetCoipPoolUsageRequest =
  struct
    type t =
      {
      pool_id: String.t [@ocaml.doc "<p>The ID of the address pool.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters. The following are the possible values:</p> <ul> <li> <p> <code>coip-address-usage.allocation-id</code> </p> </li> </ul> <ul> <li> <p> <code>coip-address-usage.aws-account-id</code> </p> </li> </ul> <ul> <li> <p> <code>coip-address-usage.aws-service</code> </p> </li> </ul> <ul> <li> <p> <code>coip-address-usage.co-ip</code> </p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return with a single call. To retrieve the remaining results, make another call with the returned <code>nextToken</code> value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next page of results.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~pool_id  ?(filters= [])  ?max_results  ?next_token  ?dry_run 
      () = { pool_id; filters; max_results; next_token; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some (Query.Pair ("PoolId", (String.to_query v.pool_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Some ("pool_id", (String.to_json v.pool_id))])
    let parse xml =
      Some
        {
          pool_id =
            (Xml.required "PoolId"
               (Util.option_bind (Xml.member "PoolId" xml) String.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "PoolId" ([], (String.to_xml v.pool_id)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filters))
             @
             [Util.option_map v.max_results
                (fun f ->
                   Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module GetCoipPoolUsageResult = GetCoipPoolUsageResult
type input = GetCoipPoolUsageRequest.t
type output = GetCoipPoolUsageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["GetCoipPoolUsage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetCoipPoolUsageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (GetCoipPoolUsageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "GetCoipPoolUsageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetCoipPoolUsageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetCoipPoolUsageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetCoipPoolUsageResult - missing field in body or children: "
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