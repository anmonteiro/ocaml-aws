open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetHealthCheckRequest =
  struct
    type t =
      {
      health_check_id: String.t
        [@ocaml.doc
          "<p>The identifier that Amazon Route 53 assigned to the health check when you created it. When you add or update a resource record set, you use this value to specify which health check to use. The value can be up to 64 characters long.</p>"]}
    [@@ocaml.doc
      "<p>A request to get information about a specified health check. </p>"]
    let make ~health_check_id  () = { health_check_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("health_check_id", (String.to_json v.health_check_id))])
    let parse xml =
      Some
        {
          health_check_id =
            (Xml.required "HealthCheckId"
               (Util.option_bind (Xml.member "HealthCheckId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "HealthCheckId"
                 ([], (String.to_xml v.health_check_id)))])
  end[@@ocaml.doc
       "<p>A request to get information about a specified health check. </p>"]
module GetHealthCheckResponse = GetHealthCheckResponse
type input = GetHealthCheckRequest.t
type output = GetHealthCheckResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/healthcheck/" ^
               req.GetHealthCheckRequest.health_check_id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetHealthCheckRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetHealthCheckRequest.to_headers req)), "")
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
            (Failure "Could not find well formed GetHealthCheckResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetHealthCheckResponse.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetHealthCheckResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetHealthCheckResponse - missing field in body or children: "
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