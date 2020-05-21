open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTrafficPolicyVersionsRequest =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>Specify the value of <code>Id</code> of the traffic policy for which you want to list all versions.</p>"];
      traffic_policy_version_marker: String.t option
        [@ocaml.doc
          "<p>For your first request to <code>ListTrafficPolicyVersions</code>, don't include the <code>TrafficPolicyVersionMarker</code> parameter.</p> <p>If you have more traffic policy versions than the value of <code>MaxItems</code>, <code>ListTrafficPolicyVersions</code> returns only the first group of <code>MaxItems</code> versions. To get more traffic policy versions, submit another <code>ListTrafficPolicyVersions</code> request. For the value of <code>TrafficPolicyVersionMarker</code>, specify the value of <code>TrafficPolicyVersionMarker</code> in the previous response.</p>"];
      max_items: String.t option
        [@ocaml.doc
          "<p>The maximum number of traffic policy versions that you want Amazon Route 53 to include in the response body for this request. If the specified traffic policy has more than <code>MaxItems</code> versions, the value of <code>IsTruncated</code> in the response is <code>true</code>, and the value of the <code>TrafficPolicyVersionMarker</code> element is the ID of the first version that Route 53 will return if you submit another request.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the information about the request to list your traffic policies.</p>"]
    let make ~id  ?traffic_policy_version_marker  ?max_items  () =
      { id; traffic_policy_version_marker; max_items }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> Query.Pair ("maxitems", (String.to_query f)));
           Util.option_map v.traffic_policy_version_marker
             (fun f ->
                Query.Pair ("trafficpolicyversion", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> ("max_items", (String.to_json f)));
           Util.option_map v.traffic_policy_version_marker
             (fun f -> ("traffic_policy_version_marker", (String.to_json f)));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          traffic_policy_version_marker =
            (Util.option_bind (Xml.member "trafficpolicyversion" xml)
               String.parse);
          max_items =
            (Util.option_bind (Xml.member "maxitems" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
            [Util.option_map v.traffic_policy_version_marker
               (fun f ->
                  Ezxmlm.make_tag "trafficpolicyversion"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_items
              (fun f -> Ezxmlm.make_tag "maxitems" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the information about the request to list your traffic policies.</p>"]
module ListTrafficPolicyVersionsResponse = ListTrafficPolicyVersionsResponse
type input = ListTrafficPolicyVersionsRequest.t
type output = ListTrafficPolicyVersionsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/2013-04-01/trafficpolicies/" ^
                req.ListTrafficPolicyVersionsRequest.id)
               ^ "/versions")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListTrafficPolicyVersionsRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (ListTrafficPolicyVersionsRequest.to_headers req)), "")
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
               "Could not find well formed ListTrafficPolicyVersionsResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListTrafficPolicyVersionsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListTrafficPolicyVersionsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTrafficPolicyVersionsResponse - missing field in body or children: "
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