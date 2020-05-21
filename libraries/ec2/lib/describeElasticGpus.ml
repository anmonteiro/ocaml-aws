open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeElasticGpusRequest =
  struct
    type t =
      {
      elastic_gpu_ids: ElasticGpuIdSet.t
        [@ocaml.doc "<p>The Elastic Graphics accelerator IDs.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>availability-zone</code> - The Availability Zone in which the Elastic Graphics accelerator resides.</p> </li> <li> <p> <code>elastic-gpu-health</code> - The status of the Elastic Graphics accelerator (<code>OK</code> | <code>IMPAIRED</code>).</p> </li> <li> <p> <code>elastic-gpu-state</code> - The state of the Elastic Graphics accelerator (<code>ATTACHED</code>).</p> </li> <li> <p> <code>elastic-gpu-type</code> - The type of Elastic Graphics accelerator; for example, <code>eg1.medium</code>.</p> </li> <li> <p> <code>instance-id</code> - The ID of the instance to which the Elastic Graphics accelerator is associated.</p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value. This value can be between 5 and 1000.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to request the next page of results.</p>"]}
    let make ?(elastic_gpu_ids= [])  ?dry_run  ?(filters= [])  ?max_results 
      ?next_token  () =
      { elastic_gpu_ids; dry_run; filters; max_results; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("ElasticGpuId",
                  (ElasticGpuIdSet.to_query v.elastic_gpu_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("elastic_gpu_ids", (ElasticGpuIdSet.to_json v.elastic_gpu_ids))])
    let parse xml =
      Some
        {
          elastic_gpu_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ElasticGpuId" xml)
                  ElasticGpuIdSet.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ElasticGpuId"
                          ([], (ElasticGpuIdSet.to_xml [x]))))
                  v.elastic_gpu_ids))
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
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
  end
module DescribeElasticGpusResult = DescribeElasticGpusResult
type input = DescribeElasticGpusRequest.t
type output = DescribeElasticGpusResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeElasticGpus"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeElasticGpusRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeElasticGpusRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeElasticGpusResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeElasticGpusResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeElasticGpusResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeElasticGpusResult - missing field in body or children: "
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