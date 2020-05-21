open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeVpcClassicLinkRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>is-classic-link-enabled</code> - Whether the VPC is enabled for ClassicLink (<code>true</code> | <code>false</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      vpc_ids: VpcClassicLinkIdList.t
        [@ocaml.doc
          "<p>One or more VPCs for which you want to describe the ClassicLink status.</p>"]}
    let make ?(filters= [])  ?dry_run  ?(vpc_ids= [])  () =
      { filters; dry_run; vpc_ids }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("VpcId", (VpcClassicLinkIdList.to_query v.vpc_ids)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("vpc_ids", (VpcClassicLinkIdList.to_json v.vpc_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          vpc_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcId" xml)
                  VpcClassicLinkIdList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "VpcId"
                      ([], (VpcClassicLinkIdList.to_xml [x])))) v.vpc_ids))
  end
module DescribeVpcClassicLinkResult = DescribeVpcClassicLinkResult
type input = DescribeVpcClassicLinkRequest.t
type output = DescribeVpcClassicLinkResult.t
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
         ("Action", ["DescribeVpcClassicLink"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeVpcClassicLinkRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeVpcClassicLinkRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeVpcClassicLinkResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeVpcClassicLinkResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeVpcClassicLinkResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeVpcClassicLinkResult - missing field in body or children: "
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