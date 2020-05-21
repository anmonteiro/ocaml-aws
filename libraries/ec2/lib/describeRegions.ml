open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeRegionsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>endpoint</code> - The endpoint of the Region (for example, <code>ec2.us-east-1.amazonaws.com</code>).</p> </li> <li> <p> <code>opt-in-status</code> - The opt-in status of the Region (<code>opt-in-not-required</code> | <code>opted-in</code> | <code>not-opted-in</code>).</p> </li> <li> <p> <code>region-name</code> - The name of the Region (for example, <code>us-east-1</code>).</p> </li> </ul>"];
      region_names: RegionNameStringList.t
        [@ocaml.doc
          "<p>The names of the Regions. You can specify any Regions, whether they are enabled and disabled for your account.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      all_regions: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether to display all Regions, including Regions that are disabled for your account.</p>"]}
    let make ?(filters= [])  ?(region_names= [])  ?dry_run  ?all_regions  ()
      = { filters; region_names; dry_run; all_regions }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.all_regions
              (fun f -> Query.Pair ("AllRegions", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("RegionName",
                  (RegionNameStringList.to_query v.region_names)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.all_regions
              (fun f -> ("all_regions", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("region_names", (RegionNameStringList.to_json v.region_names));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          region_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "RegionName" xml)
                  RegionNameStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          all_regions =
            (Util.option_bind (Xml.member "AllRegions" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filters))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "RegionName"
                        ([], (RegionNameStringList.to_xml [x]))))
                v.region_names))
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.all_regions
              (fun f -> Ezxmlm.make_tag "AllRegions" ([], (Boolean.to_xml f)))])
  end
module DescribeRegionsResult = DescribeRegionsResult
type input = DescribeRegionsRequest.t
type output = DescribeRegionsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeRegions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeRegionsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeRegionsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeRegionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeRegionsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeRegionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeRegionsResult - missing field in body or children: "
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