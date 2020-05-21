open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeLaunchTemplatesRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      launch_template_ids: ValueStringList.t
        [@ocaml.doc "<p>One or more launch template IDs.</p>"];
      launch_template_names: LaunchTemplateNameStringList.t
        [@ocaml.doc "<p>One or more launch template names.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>create-time</code> - The time the launch template was created.</p> </li> <li> <p> <code>launch-template-name</code> - The name of the launch template.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to request the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value. This value can be between 1 and 200.</p>"]}
    let make ?dry_run  ?(launch_template_ids= [])  ?(launch_template_names=
      [])  ?(filters= [])  ?next_token  ?max_results  () =
      {
        dry_run;
        launch_template_ids;
        launch_template_names;
        filters;
        next_token;
        max_results
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("LaunchTemplateName",
                  (LaunchTemplateNameStringList.to_query
                     v.launch_template_names)));
           Some
             (Query.Pair
                ("LaunchTemplateId",
                  (ValueStringList.to_query v.launch_template_ids)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Some
             ("launch_template_names",
               (LaunchTemplateNameStringList.to_json v.launch_template_names));
           Some
             ("launch_template_ids",
               (ValueStringList.to_json v.launch_template_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          launch_template_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "LaunchTemplateId" xml)
                  ValueStringList.parse));
          launch_template_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "LaunchTemplateName" xml)
                  LaunchTemplateNameStringList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.dry_run
                   (fun f ->
                      Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "LaunchTemplateId"
                          ([], (ValueStringList.to_xml [x]))))
                  v.launch_template_ids))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "LaunchTemplateName"
                         ([], (LaunchTemplateNameStringList.to_xml [x]))))
                 v.launch_template_names))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
  end
module DescribeLaunchTemplatesResult = DescribeLaunchTemplatesResult
type input = DescribeLaunchTemplatesRequest.t
type output = DescribeLaunchTemplatesResult.t
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
         ("Action", ["DescribeLaunchTemplates"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeLaunchTemplatesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeLaunchTemplatesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeLaunchTemplatesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeLaunchTemplatesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeLaunchTemplatesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeLaunchTemplatesResult - missing field in body or children: "
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