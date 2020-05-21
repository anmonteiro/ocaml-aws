open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateHealthCheckRequest =
  struct
    type t =
      {
      caller_reference: String.t
        [@ocaml.doc
          "<p>A unique string that identifies the request and that allows you to retry a failed <code>CreateHealthCheck</code> request without the risk of creating two identical health checks:</p> <ul> <li> <p>If you send a <code>CreateHealthCheck</code> request with the same <code>CallerReference</code> and settings as a previous request, and if the health check doesn't exist, Amazon Route 53 creates the health check. If the health check does exist, Route 53 returns the settings for the existing health check.</p> </li> <li> <p>If you send a <code>CreateHealthCheck</code> request with the same <code>CallerReference</code> as a deleted health check, regardless of the settings, Route 53 returns a <code>HealthCheckAlreadyExists</code> error.</p> </li> <li> <p>If you send a <code>CreateHealthCheck</code> request with the same <code>CallerReference</code> as an existing health check but with different settings, Route 53 returns a <code>HealthCheckAlreadyExists</code> error.</p> </li> <li> <p>If you send a <code>CreateHealthCheck</code> request with a unique <code>CallerReference</code> but settings identical to an existing health check, Route 53 creates the health check.</p> </li> </ul>"];
      health_check_config: HealthCheckConfig.t
        [@ocaml.doc
          "<p>A complex type that contains settings for a new health check.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the health check request information.</p>"]
    let make ~caller_reference  ~health_check_config  () =
      { caller_reference; health_check_config }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("health_check_config",
                (HealthCheckConfig.to_json v.health_check_config));
           Some ("caller_reference", (String.to_json v.caller_reference))])
    let parse xml =
      Some
        {
          caller_reference =
            (Xml.required "CallerReference"
               (Util.option_bind (Xml.member "CallerReference" xml)
                  String.parse));
          health_check_config =
            (Xml.required "HealthCheckConfig"
               (Util.option_bind (Xml.member "HealthCheckConfig" xml)
                  HealthCheckConfig.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "CallerReference"
                  ([], (String.to_xml v.caller_reference)))])
           @
           [Some
              (Ezxmlm.make_tag "HealthCheckConfig"
                 ([], (HealthCheckConfig.to_xml v.health_check_config)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the health check request information.</p>"]
module CreateHealthCheckResponse = CreateHealthCheckResponse
type input = CreateHealthCheckRequest.t
type output = CreateHealthCheckResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/healthcheck"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateHealthCheckRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CreateHealthCheckRequest.to_headers req)),
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
            (Failure "Could not find well formed CreateHealthCheckResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateHealthCheckResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateHealthCheckResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateHealthCheckResponse - missing field in body or children: "
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