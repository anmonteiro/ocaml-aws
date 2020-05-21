open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTrafficPolicyInstanceRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that you want Amazon Route 53 to create resource record sets in by using the configuration in a traffic policy.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The domain name (such as example.com) or subdomain name (such as www.example.com) for which Amazon Route 53 responds to DNS queries by using the resource record sets that Route 53 creates for this traffic policy instance.</p>"];
      t_t_l: Long.t
        [@ocaml.doc
          "<p>(Optional) The TTL that you want Amazon Route 53 to assign to all of the resource record sets that it creates in the specified hosted zone.</p>"];
      traffic_policy_id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy that you want to use to create resource record sets in the specified hosted zone.</p>"];
      traffic_policy_version: Integer.t
        [@ocaml.doc
          "<p>The version of the traffic policy that you want to use to create resource record sets in the specified hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the resource record sets that you want to create based on a specified traffic policy.</p>"]
    let make ~hosted_zone_id  ~name  ~t_t_l  ~traffic_policy_id 
      ~traffic_policy_version  () =
      {
        hosted_zone_id;
        name;
        t_t_l;
        traffic_policy_id;
        traffic_policy_version
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("traffic_policy_version",
                (Integer.to_json v.traffic_policy_version));
           Some ("traffic_policy_id", (String.to_json v.traffic_policy_id));
           Some ("t_t_l", (Long.to_json v.t_t_l));
           Some ("name", (String.to_json v.name));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "HostedZoneId"
               (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse));
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          t_t_l =
            (Xml.required "TTL"
               (Util.option_bind (Xml.member "TTL" xml) Long.parse));
          traffic_policy_id =
            (Xml.required "TrafficPolicyId"
               (Util.option_bind (Xml.member "TrafficPolicyId" xml)
                  String.parse));
          traffic_policy_version =
            (Xml.required "TrafficPolicyVersion"
               (Util.option_bind (Xml.member "TrafficPolicyVersion" xml)
                  Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "HostedZoneId"
                     ([], (String.to_xml v.hosted_zone_id)))])
              @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
             @ [Some (Ezxmlm.make_tag "TTL" ([], (Long.to_xml v.t_t_l)))])
            @
            [Some
               (Ezxmlm.make_tag "TrafficPolicyId"
                  ([], (String.to_xml v.traffic_policy_id)))])
           @
           [Some
              (Ezxmlm.make_tag "TrafficPolicyVersion"
                 ([], (Integer.to_xml v.traffic_policy_version)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the resource record sets that you want to create based on a specified traffic policy.</p>"]
module CreateTrafficPolicyInstanceResponse =
  CreateTrafficPolicyInstanceResponse
type input = CreateTrafficPolicyInstanceRequest.t
type output = CreateTrafficPolicyInstanceResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/trafficpolicyinstance"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateTrafficPolicyInstanceRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (CreateTrafficPolicyInstanceRequest.to_headers req)), "")
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
               "Could not find well formed CreateTrafficPolicyInstanceResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTrafficPolicyInstanceResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTrafficPolicyInstanceResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTrafficPolicyInstanceResponse - missing field in body or children: "
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