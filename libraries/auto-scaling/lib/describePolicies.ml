open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribePoliciesType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      policy_names: PolicyNames.t
        [@ocaml.doc
          "<p>The names of one or more policies. If you omit this parameter, all policies are described. If a group name is provided, the results are limited to that group. This list is limited to 50 items. If you specify an unknown policy name, it is ignored with no error.</p>"];
      policy_types: PolicyTypes.t
        [@ocaml.doc
          "<p>One or more policy types. The valid values are <code>SimpleScaling</code>, <code>StepScaling</code>, and <code>TargetTrackingScaling</code>.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to be returned with each call. The default value is <code>50</code> and the maximum value is <code>100</code>.</p>"]}
    let make ?auto_scaling_group_name  ?(policy_names= [])  ?(policy_types=
      [])  ?next_token  ?max_records  () =
      {
        auto_scaling_group_name;
        policy_names;
        policy_types;
        next_token;
        max_records
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("policy_types", (PolicyTypes.to_json v.policy_types));
           Some ("policy_names", (PolicyNames.to_json v.policy_names));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          policy_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "PolicyNames" xml)
                  PolicyNames.parse));
          policy_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "PolicyTypes" xml)
                  PolicyTypes.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.auto_scaling_group_name
                  (fun f ->
                     Ezxmlm.make_tag "AutoScalingGroupName"
                       ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "PolicyNames"
                         ([], (PolicyNames.to_xml [x])))) v.policy_names))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "PolicyTypes"
                        ([], (PolicyTypes.to_xml [x])))) v.policy_types))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
  end
module PoliciesType = PoliciesType
type input = DescribePoliciesType.t
type output = PoliciesType.t
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]); ("Action", ["DescribePolicies"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribePoliciesType.to_query req))))) in
  (`POST, uri, (Headers.render (DescribePoliciesType.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribePoliciesResponse" (snd xml))
        (Xml.member "DescribePoliciesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp PoliciesType.parse)
          (BadResponse
             { body; message = "Could not find well formed PoliciesType." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PoliciesType - missing field in body or children: "
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