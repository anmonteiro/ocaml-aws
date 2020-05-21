open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeBundleTasksRequest =
  struct
    type t =
      {
      bundle_ids: BundleIdStringList.t
        [@ocaml.doc
          "<p>The bundle task IDs.</p> <p>Default: Describes all your bundle tasks.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>bundle-id</code> - The ID of the bundle task.</p> </li> <li> <p> <code>error-code</code> - If the task failed, the error code returned.</p> </li> <li> <p> <code>error-message</code> - If the task failed, the error message returned.</p> </li> <li> <p> <code>instance-id</code> - The ID of the instance.</p> </li> <li> <p> <code>progress</code> - The level of task completion, as a percentage (for example, 20%).</p> </li> <li> <p> <code>s3-bucket</code> - The Amazon S3 bucket to store the AMI.</p> </li> <li> <p> <code>s3-prefix</code> - The beginning of the AMI name.</p> </li> <li> <p> <code>start-time</code> - The time the task started (for example, 2013-09-15T17:15:20.000Z).</p> </li> <li> <p> <code>state</code> - The state of the task (<code>pending</code> | <code>waiting-for-shutdown</code> | <code>bundling</code> | <code>storing</code> | <code>cancelling</code> | <code>complete</code> | <code>failed</code>).</p> </li> <li> <p> <code>update-time</code> - The time of the most recent update for the task.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(bundle_ids= [])  ?(filters= [])  ?dry_run  () =
      { bundle_ids; filters; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("BundleId", (BundleIdStringList.to_query v.bundle_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Some ("bundle_ids", (BundleIdStringList.to_json v.bundle_ids))])
    let parse xml =
      Some
        {
          bundle_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "BundleId" xml)
                  BundleIdStringList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "BundleId"
                        ([], (BundleIdStringList.to_xml [x])))) v.bundle_ids))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
               v.filters))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeBundleTasksResult = DescribeBundleTasksResult
type input = DescribeBundleTasksRequest.t
type output = DescribeBundleTasksResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeBundleTasks"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeBundleTasksRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeBundleTasksRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeBundleTasksResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeBundleTasksResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeBundleTasksResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeBundleTasksResult - missing field in body or children: "
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