open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeLaunchTemplateVersionsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      launch_template_id: String.t option
        [@ocaml.doc
          "<p>The ID of the launch template. You must specify either the launch template ID or launch template name in the request.</p>"];
      launch_template_name: String.t option
        [@ocaml.doc
          "<p>The name of the launch template. You must specify either the launch template ID or launch template name in the request.</p>"];
      versions: VersionStringList.t
        [@ocaml.doc "<p>One or more versions of the launch template.</p>"];
      min_version: String.t option
        [@ocaml.doc
          "<p>The version number after which to describe launch template versions.</p>"];
      max_version: String.t option
        [@ocaml.doc
          "<p>The version number up to which to describe launch template versions.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to request the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value. This value can be between 1 and 200.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>create-time</code> - The time the launch template version was created.</p> </li> <li> <p> <code>ebs-optimized</code> - A boolean that indicates whether the instance is optimized for Amazon EBS I/O.</p> </li> <li> <p> <code>iam-instance-profile</code> - The ARN of the IAM instance profile.</p> </li> <li> <p> <code>image-id</code> - The ID of the AMI.</p> </li> <li> <p> <code>instance-type</code> - The instance type.</p> </li> <li> <p> <code>is-default-version</code> - A boolean that indicates whether the launch template version is the default version.</p> </li> <li> <p> <code>kernel-id</code> - The kernel ID.</p> </li> <li> <p> <code>ram-disk-id</code> - The RAM disk ID.</p> </li> </ul>"]}
    let make ?dry_run  ?launch_template_id  ?launch_template_name 
      ?(versions= [])  ?min_version  ?max_version  ?next_token  ?max_results 
      ?(filters= [])  () =
      {
        dry_run;
        launch_template_id;
        launch_template_name;
        versions;
        min_version;
        max_version;
        next_token;
        max_results;
        filters
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_version
             (fun f -> Query.Pair ("MaxVersion", (String.to_query f)));
           Util.option_map v.min_version
             (fun f -> Query.Pair ("MinVersion", (String.to_query f)));
           Some
             (Query.Pair
                ("LaunchTemplateVersion",
                  (VersionStringList.to_query v.versions)));
           Util.option_map v.launch_template_name
             (fun f -> Query.Pair ("LaunchTemplateName", (String.to_query f)));
           Util.option_map v.launch_template_id
             (fun f -> Query.Pair ("LaunchTemplateId", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_version
             (fun f -> ("max_version", (String.to_json f)));
           Util.option_map v.min_version
             (fun f -> ("min_version", (String.to_json f)));
           Some ("versions", (VersionStringList.to_json v.versions));
           Util.option_map v.launch_template_name
             (fun f -> ("launch_template_name", (String.to_json f)));
           Util.option_map v.launch_template_id
             (fun f -> ("launch_template_id", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          launch_template_id =
            (Util.option_bind (Xml.member "LaunchTemplateId" xml)
               String.parse);
          launch_template_name =
            (Util.option_bind (Xml.member "LaunchTemplateName" xml)
               String.parse);
          versions =
            (Util.of_option []
               (Util.option_bind (Xml.member "LaunchTemplateVersion" xml)
                  VersionStringList.parse));
          min_version =
            (Util.option_bind (Xml.member "MinVersion" xml) String.parse);
          max_version =
            (Util.option_bind (Xml.member "MaxVersion" xml) String.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.dry_run
                      (fun f ->
                         Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
                  @
                  [Util.option_map v.launch_template_id
                     (fun f ->
                        Ezxmlm.make_tag "LaunchTemplateId"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.launch_template_name
                    (fun f ->
                       Ezxmlm.make_tag "LaunchTemplateName"
                         ([], (String.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "LaunchTemplateVersion"
                           ([], (VersionStringList.to_xml [x])))) v.versions))
               @
               [Util.option_map v.min_version
                  (fun f ->
                     Ezxmlm.make_tag "MinVersion" ([], (String.to_xml f)))])
              @
              [Util.option_map v.max_version
                 (fun f ->
                    Ezxmlm.make_tag "MaxVersion" ([], (String.to_xml f)))])
             @
             [Util.option_map v.next_token
                (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
              v.filters))
  end
module DescribeLaunchTemplateVersionsResult =
  DescribeLaunchTemplateVersionsResult
type input = DescribeLaunchTemplateVersionsRequest.t
type output = DescribeLaunchTemplateVersionsResult.t
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
         ("Action", ["DescribeLaunchTemplateVersions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeLaunchTemplateVersionsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeLaunchTemplateVersionsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeLaunchTemplateVersionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeLaunchTemplateVersionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeLaunchTemplateVersionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeLaunchTemplateVersionsResult - missing field in body or children: "
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