open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTrafficPolicyInstancesByHostedZoneRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that you want to list traffic policy instances for.</p>"];
      traffic_policy_instance_name_marker: String.t option
        [@ocaml.doc
          "<p>If the value of <code>IsTruncated</code> in the previous response is true, you have more traffic policy instances. To get more traffic policy instances, submit another <code>ListTrafficPolicyInstances</code> request. For the value of <code>trafficpolicyinstancename</code>, specify the value of <code>TrafficPolicyInstanceNameMarker</code> from the previous response, which is the name of the first traffic policy instance in the next group of traffic policy instances.</p> <p>If the value of <code>IsTruncated</code> in the previous response was <code>false</code>, there are no more traffic policy instances to get.</p>"];
      traffic_policy_instance_type_marker: RRType.t option
        [@ocaml.doc
          "<p>If the value of <code>IsTruncated</code> in the previous response is true, you have more traffic policy instances. To get more traffic policy instances, submit another <code>ListTrafficPolicyInstances</code> request. For the value of <code>trafficpolicyinstancetype</code>, specify the value of <code>TrafficPolicyInstanceTypeMarker</code> from the previous response, which is the type of the first traffic policy instance in the next group of traffic policy instances.</p> <p>If the value of <code>IsTruncated</code> in the previous response was <code>false</code>, there are no more traffic policy instances to get.</p>"];
      max_items: String.t option
        [@ocaml.doc
          "<p>The maximum number of traffic policy instances to be included in the response body for this request. If you have more than <code>MaxItems</code> traffic policy instances, the value of the <code>IsTruncated</code> element in the response is <code>true</code>, and the values of <code>HostedZoneIdMarker</code>, <code>TrafficPolicyInstanceNameMarker</code>, and <code>TrafficPolicyInstanceTypeMarker</code> represent the first traffic policy instance that Amazon Route 53 will return if you submit another request.</p>"]}
    [@@ocaml.doc
      "<p>A request for the traffic policy instances that you created in a specified hosted zone.</p>"]
    let make ~hosted_zone_id  ?traffic_policy_instance_name_marker 
      ?traffic_policy_instance_type_marker  ?max_items  () =
      {
        hosted_zone_id;
        traffic_policy_instance_name_marker;
        traffic_policy_instance_type_marker;
        max_items
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> Query.Pair ("maxitems", (String.to_query f)));
           Util.option_map v.traffic_policy_instance_type_marker
             (fun f ->
                Query.Pair ("trafficpolicyinstancetype", (RRType.to_query f)));
           Util.option_map v.traffic_policy_instance_name_marker
             (fun f ->
                Query.Pair ("trafficpolicyinstancename", (String.to_query f)));
           Some (Query.Pair ("id", (String.to_query v.hosted_zone_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> ("max_items", (String.to_json f)));
           Util.option_map v.traffic_policy_instance_type_marker
             (fun f ->
                ("traffic_policy_instance_type_marker", (RRType.to_json f)));
           Util.option_map v.traffic_policy_instance_name_marker
             (fun f ->
                ("traffic_policy_instance_name_marker", (String.to_json f)));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse));
          traffic_policy_instance_name_marker =
            (Util.option_bind (Xml.member "trafficpolicyinstancename" xml)
               String.parse);
          traffic_policy_instance_type_marker =
            (Util.option_bind (Xml.member "trafficpolicyinstancetype" xml)
               RRType.parse);
          max_items =
            (Util.option_bind (Xml.member "maxitems" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "id" ([], (String.to_xml v.hosted_zone_id)))])
             @
             [Util.option_map v.traffic_policy_instance_name_marker
                (fun f ->
                   Ezxmlm.make_tag "trafficpolicyinstancename"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.traffic_policy_instance_type_marker
               (fun f ->
                  Ezxmlm.make_tag "trafficpolicyinstancetype"
                    ([], (RRType.to_xml f)))])
           @
           [Util.option_map v.max_items
              (fun f -> Ezxmlm.make_tag "maxitems" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A request for the traffic policy instances that you created in a specified hosted zone.</p>"]
module ListTrafficPolicyInstancesByHostedZoneResponse =
  ListTrafficPolicyInstancesByHostedZoneResponse
type input = ListTrafficPolicyInstancesByHostedZoneRequest.t
type output = ListTrafficPolicyInstancesByHostedZoneResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/trafficpolicyinstances/hostedzone"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (ListTrafficPolicyInstancesByHostedZoneRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render
       (ListTrafficPolicyInstancesByHostedZoneRequest.to_headers req)), "")
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
               "Could not find well formed ListTrafficPolicyInstancesByHostedZoneResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ListTrafficPolicyInstancesByHostedZoneResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListTrafficPolicyInstancesByHostedZoneResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTrafficPolicyInstancesByHostedZoneResponse - missing field in body or children: "
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