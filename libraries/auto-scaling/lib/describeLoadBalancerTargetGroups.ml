open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeLoadBalancerTargetGroupsRequest =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return with this call. The default value is <code>100</code> and the maximum value is <code>100</code>.</p>"]}
    let make ~auto_scaling_group_name  ?next_token  ?max_records  () =
      { auto_scaling_group_name; next_token; max_records }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
  end
module DescribeLoadBalancerTargetGroupsResponse =
  DescribeLoadBalancerTargetGroupsResponse
type input = DescribeLoadBalancerTargetGroupsRequest.t
type output = DescribeLoadBalancerTargetGroupsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]);
         ("Action", ["DescribeLoadBalancerTargetGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeLoadBalancerTargetGroupsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeLoadBalancerTargetGroupsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeLoadBalancerTargetGroupsResponse" (snd xml))
        (Xml.member "DescribeLoadBalancerTargetGroupsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DescribeLoadBalancerTargetGroupsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeLoadBalancerTargetGroupsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeLoadBalancerTargetGroupsResponse - missing field in body or children: "
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