open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeFpgaImagesRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      fpga_image_ids: FpgaImageIdList.t [@ocaml.doc "<p>The AFI IDs.</p>"];
      owners: OwnerStringList.t
        [@ocaml.doc
          "<p>Filters the AFI by owner. Specify an AWS account ID, <code>self</code> (owner is the sender of the request), or an AWS owner alias (valid values are <code>amazon</code> | <code>aws-marketplace</code>).</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>create-time</code> - The creation time of the AFI.</p> </li> <li> <p> <code>fpga-image-id</code> - The FPGA image identifier (AFI ID).</p> </li> <li> <p> <code>fpga-image-global-id</code> - The global FPGA image identifier (AGFI ID).</p> </li> <li> <p> <code>name</code> - The name of the AFI.</p> </li> <li> <p> <code>owner-id</code> - The AWS account ID of the AFI owner.</p> </li> <li> <p> <code>product-code</code> - The product code.</p> </li> <li> <p> <code>shell-version</code> - The version of the AWS Shell that was used to create the bitstream.</p> </li> <li> <p> <code>state</code> - The state of the AFI (<code>pending</code> | <code>failed</code> | <code>available</code> | <code>unavailable</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>update-time</code> - The time of the most recent update.</p> </li> </ul>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to retrieve the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call.</p>"]}
    let make ?dry_run  ?(fpga_image_ids= [])  ?(owners= [])  ?(filters= []) 
      ?next_token  ?max_results  () =
      { dry_run; fpga_image_ids; owners; filters; next_token; max_results }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some (Query.Pair ("Owner", (OwnerStringList.to_query v.owners)));
           Some
             (Query.Pair
                ("FpgaImageId", (FpgaImageIdList.to_query v.fpga_image_ids)));
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
           Some ("owners", (OwnerStringList.to_json v.owners));
           Some
             ("fpga_image_ids", (FpgaImageIdList.to_json v.fpga_image_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          fpga_image_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "FpgaImageId" xml)
                  FpgaImageIdList.parse));
          owners =
            (Util.of_option []
               (Util.option_bind (Xml.member "Owner" xml)
                  OwnerStringList.parse));
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
                       (Ezxmlm.make_tag "FpgaImageId"
                          ([], (FpgaImageIdList.to_xml [x]))))
                  v.fpga_image_ids))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Owner"
                         ([], (OwnerStringList.to_xml [x])))) v.owners))
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
module DescribeFpgaImagesResult = DescribeFpgaImagesResult
type input = DescribeFpgaImagesRequest.t
type output = DescribeFpgaImagesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeFpgaImages"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeFpgaImagesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeFpgaImagesRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeFpgaImagesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeFpgaImagesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeFpgaImagesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeFpgaImagesResult - missing field in body or children: "
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