open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateTrafficPolicyInstanceRequest =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy instance that you want to update.</p>"];
      t_t_l: Long.t
        [@ocaml.doc
          "<p>The TTL that you want Amazon Route 53 to assign to all of the updated resource record sets.</p>"];
      traffic_policy_id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy that you want Amazon Route 53 to use to update resource record sets for the specified traffic policy instance.</p>"];
      traffic_policy_version: Integer.t
        [@ocaml.doc
          "<p>The version of the traffic policy that you want Amazon Route 53 to use to update resource record sets for the specified traffic policy instance.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the resource record sets that you want to update based on a specified traffic policy instance.</p>"]
    let make ~id  ~t_t_l  ~traffic_policy_id  ~traffic_policy_version  () =
      { id; t_t_l; traffic_policy_id; traffic_policy_version }
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
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
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
        (((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
             [Some (Ezxmlm.make_tag "TTL" ([], (Long.to_xml v.t_t_l)))])
            @
            [Some
               (Ezxmlm.make_tag "TrafficPolicyId"
                  ([], (String.to_xml v.traffic_policy_id)))])
           @
           [Some
              (Ezxmlm.make_tag "TrafficPolicyVersion"
                 ([], (Integer.to_xml v.traffic_policy_version)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the resource record sets that you want to update based on a specified traffic policy instance.</p>"]
module UpdateTrafficPolicyInstanceResponse =
  UpdateTrafficPolicyInstanceResponse
type input = UpdateTrafficPolicyInstanceRequest.t
type output = UpdateTrafficPolicyInstanceResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/trafficpolicyinstance/" ^
               req.UpdateTrafficPolicyInstanceRequest.id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (UpdateTrafficPolicyInstanceRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateTrafficPolicyInstanceRequest.to_headers req)), "")
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
               "Could not find well formed UpdateTrafficPolicyInstanceResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp UpdateTrafficPolicyInstanceResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed UpdateTrafficPolicyInstanceResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateTrafficPolicyInstanceResponse - missing field in body or children: "
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