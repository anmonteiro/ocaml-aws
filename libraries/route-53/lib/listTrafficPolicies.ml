open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTrafficPoliciesRequest =
  struct
    type t =
      {
      traffic_policy_id_marker: String.t option
        [@ocaml.doc
          "<p>(Conditional) For your first request to <code>ListTrafficPolicies</code>, don't include the <code>TrafficPolicyIdMarker</code> parameter.</p> <p>If you have more traffic policies than the value of <code>MaxItems</code>, <code>ListTrafficPolicies</code> returns only the first <code>MaxItems</code> traffic policies. To get the next group of policies, submit another request to <code>ListTrafficPolicies</code>. For the value of <code>TrafficPolicyIdMarker</code>, specify the value of <code>TrafficPolicyIdMarker</code> that was returned in the previous response.</p>"];
      max_items: String.t option
        [@ocaml.doc
          "<p>(Optional) The maximum number of traffic policies that you want Amazon Route 53 to return in response to this request. If you have more than <code>MaxItems</code> traffic policies, the value of <code>IsTruncated</code> in the response is <code>true</code>, and the value of <code>TrafficPolicyIdMarker</code> is the ID of the first traffic policy that Route 53 will return if you submit another request.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the information about the request to list the traffic policies that are associated with the current AWS account.</p>"]
    let make ?traffic_policy_id_marker  ?max_items  () =
      { traffic_policy_id_marker; max_items }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> Query.Pair ("maxitems", (String.to_query f)));
           Util.option_map v.traffic_policy_id_marker
             (fun f -> Query.Pair ("trafficpolicyid", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> ("max_items", (String.to_json f)));
           Util.option_map v.traffic_policy_id_marker
             (fun f -> ("traffic_policy_id_marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          traffic_policy_id_marker =
            (Util.option_bind (Xml.member "trafficpolicyid" xml) String.parse);
          max_items =
            (Util.option_bind (Xml.member "maxitems" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.traffic_policy_id_marker
               (fun f ->
                  Ezxmlm.make_tag "trafficpolicyid" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_items
              (fun f -> Ezxmlm.make_tag "maxitems" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the information about the request to list the traffic policies that are associated with the current AWS account.</p>"]
module ListTrafficPoliciesResponse = ListTrafficPoliciesResponse
type input = ListTrafficPoliciesRequest.t
type output = ListTrafficPoliciesResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/trafficpolicies"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListTrafficPoliciesRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListTrafficPoliciesRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure
               "Could not find well formed ListTrafficPoliciesResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListTrafficPoliciesResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListTrafficPoliciesResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTrafficPoliciesResponse - missing field in body or children: "
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