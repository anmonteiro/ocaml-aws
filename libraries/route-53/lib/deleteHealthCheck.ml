open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteHealthCheckRequest =
  struct
    type t =
      {
      health_check_id: String.t
        [@ocaml.doc
          "<p>The ID of the health check that you want to delete.</p>"]}
    [@@ocaml.doc "<p>This action deletes a health check.</p>"]
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
  end[@@ocaml.doc "<p>This action deletes a health check.</p>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteHealthCheckRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/healthcheck/" ^
               req.DeleteHealthCheckRequest.health_check_id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (DeleteHealthCheckRequest.to_query req)))) in
  (`DELETE, uri, (Headers.render (DeleteHealthCheckRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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