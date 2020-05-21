open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeVpcClassicLinkDnsSupportRequest =
  struct
    type t =
      {
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return with a single call. To retrieve the remaining results, make another call with the returned <code>nextToken</code> value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next page of results.</p>"];
      vpc_ids: VpcClassicLinkIdList.t
        [@ocaml.doc "<p>One or more VPC IDs.</p>"]}
    let make ?max_results  ?next_token  ?(vpc_ids= [])  () =
      { max_results; next_token; vpc_ids }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("VpcIds", (VpcClassicLinkIdList.to_query v.vpc_ids)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("vpc_ids", (VpcClassicLinkIdList.to_json v.vpc_ids));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          max_results =
            (Util.option_bind (Xml.member "maxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse);
          vpc_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcIds" xml)
                  VpcClassicLinkIdList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.max_results
                (fun f ->
                   Ezxmlm.make_tag "maxResults" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "VpcIds"
                      ([], (VpcClassicLinkIdList.to_xml [x])))) v.vpc_ids))
  end
module DescribeVpcClassicLinkDnsSupportResult =
  DescribeVpcClassicLinkDnsSupportResult
type input = DescribeVpcClassicLinkDnsSupportRequest.t
type output = DescribeVpcClassicLinkDnsSupportResult.t
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
         ("Action", ["DescribeVpcClassicLinkDnsSupport"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeVpcClassicLinkDnsSupportRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeVpcClassicLinkDnsSupportRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DescribeVpcClassicLinkDnsSupportResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeVpcClassicLinkDnsSupportResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeVpcClassicLinkDnsSupportResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeVpcClassicLinkDnsSupportResult - missing field in body or children: "
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